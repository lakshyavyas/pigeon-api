# frozen_string_literal: true

module ActiveRecord
  # Schema Dumper to support for multiple schemas
  class SchemaDumper
    # Overridden in order to call new method "schemas".
    def dump(stream)
      header(stream)
      extensions(stream)
      schemas(stream)
      tables(stream)
      trailer(stream)
      stream
    end

    private

    # Adds following lines just after the extensions:
    # * connection.execute "CREATE SCHEMA ..."
    # * connection.schema_search_path = ...
    def schemas(stream)
      @connection.schema_search_path.split(',').each do |name|
        stream.puts %(  connection.execute "CREATE SCHEMA IF NOT EXISTS #{name}")
      end
      stream.puts ''
      stream.puts %(  connection.schema_search_path = #{@connection.schema_search_path.inspect})
      stream.puts ''
    end

    # Overridden in order to build a list of tables with their schema prefix
    # (rest of the method is the same).
    def tables(stream)
      table_query = <<-SQL
        SELECT schemaname, tablename
        FROM pg_tables
        WHERE schemaname = ANY(current_schemas(false))
      SQL

      sorted_tables = @connection.exec_query(table_query, 'SCHEMA').map do |table|
        "#{table['schemaname']}.#{table['tablename']}"
      end.sort

      sorted_tables.each do |table_name|
        table(table_name, stream) unless ignored?(table_name.split('.')[1])
      end

      return unless @connection.supports_foreign_keys?

      sorted_tables.each do |tbl|
        foreign_keys(tbl, stream) unless ignored?(tbl)
      end
    end

    def table(table, stream)
      columns = @connection.columns(table)
      begin
        self.table_name = table

        tbl = StringIO.new

        # first dump primary key column
        pk = @connection.primary_key(table)

        tbl.print "  create_table #{remove_prefix_and_suffix(table).inspect}"

        case pk
        when String
          tbl.print ", primary_key: #{pk.inspect}" unless pk == 'id'
          pkcol = columns.detect { |c| c.name == pk }
          pkcolspec = column_spec_for_primary_key_custom(pkcol)
          unless pkcolspec.empty?
            if pkcolspec != pkcolspec.slice(:id, :default)
              pkcolspec = { id: { type: pkcolspec.delete(:id), **pkcolspec }.compact }
            end
            tbl.print ", #{format_colspec(pkcolspec)}"
          end
        when Array
          tbl.print ", primary_key: #{pk.inspect}"
        else
          tbl.print ', id: false'
        end

        table_options = @connection.table_options(table)
        tbl.print ", #{format_options(table_options)}" if table_options.present?

        tbl.puts ', force: :cascade do |t|'

        # then dump all non-primary key columns
        columns.each do |column|
          unless @connection.valid_type?(column.type)
            raise StandardError,
                  "Unknown type '#{column.sql_type}' for column '#{column.name}'"
          end
          next if column.name == pk

          type, colspec = column_spec(column)
          if type.is_a?(Symbol)
            tbl.print "    t.#{type} #{column.name.inspect}"
          else
            tbl.print "    t.column #{column.name.inspect}, #{type.inspect}"
          end
          tbl.print ", #{format_colspec(colspec)}" if colspec.present?
          tbl.puts
        end

        indexes_in_create(table, tbl)
        check_constraints_in_create(table, tbl) if @connection.supports_check_constraints?

        tbl.puts '  end'
        tbl.puts

        tbl.rewind
        stream.print tbl.read
      rescue StandardError => e
        stream.puts "# Could not dump table #{table.inspect} because of following #{e.class}"
        stream.puts "#   #{e.message}"
        stream.puts
      ensure
        self.table_name = nil
      end
    end

    def column_spec_for_primary_key_custom(column)
      spec = {}
      spec[:id] = schema_type_custom(column).inspect unless default_primary_key_custom?(column)
      spec.merge!(prepare_column_options(column).except!(:null, :default))
      spec
    end

    def schema_type_custom(column)
      return schema_type(column) unless column.serial?

      if column.bigint?
        :bigserial
      else
        :serial
      end
    end

    def default_primary_key_custom?(column)
      schema_type(column) == :bigint
    end
  end
end
