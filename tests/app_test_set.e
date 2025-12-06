note
	description: "Test set for simple_app_api"
	author: "Larry Rix"

class
	APP_TEST_SET

inherit
	ANY

create
	default_create

feature -- Alpine Tests

	test_new_alpine_factory
			-- Test creating Alpine factory.
		local
			app: APP
		do
			create app.make
			check factory_created: app.new_alpine_factory /= Void end
		end

	test_alpine_direct_access
			-- Test direct Alpine access.
		local
			app: APP
		do
			create app.make
			check alpine_available: app.alpine /= Void end
		end

feature -- Web Client Tests

	test_new_web_client
			-- Test creating web client.
		local
			app: APP
		do
			create app.make
			check client_created: app.new_web_client /= Void end
		end

	test_web_client_direct_access
			-- Test direct web client access.
		local
			app: APP
		do
			create app.make
			check web_client_available: app.web_client /= Void end
		end

feature -- Service Inheritance Tests

	test_service_features_available
			-- Test that SERVICE features are available through APP.
		local
			app: APP
		do
			create app.make
			-- Test JWT access from SERVICE
			check jwt_available: app.new_jwt ("test-secret") /= Void end
			-- Test CORS access from SERVICE
			check cors_available: app.new_cors /= Void end
		end

feature -- Foundation Inheritance Tests

	test_foundation_features_available
			-- Test that FOUNDATION features are available through APP.
		local
			app: APP
			encoded: STRING
			hash: STRING
		do
			create app.make
			-- Test Base64 from FOUNDATION
			encoded := app.base64_encode ("test")
			check encoded_not_empty: not encoded.is_empty end
			-- Test SHA256 from FOUNDATION
			hash := app.sha256 ("password")
			check hash_not_empty: not hash.is_empty end
		end

end
