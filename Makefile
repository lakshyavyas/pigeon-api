.SILENT: features
features:
	NO_COVERAGE=true bundle exec rspec --tag feature --format json --out design/features.json || true
	bin/generate_features_report
	rm design/features.json
