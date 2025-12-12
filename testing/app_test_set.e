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
			api: APP_API
		do
			create api.make
			check factory_created: api.new_alpine_factory /= Void end
		end

	test_alpine_direct_access
			-- Test direct Alpine access.
		local
			api: APP_API
		do
			create api.make
			check alpine_available: api.alpine /= Void end
		end

feature -- Web Client Tests

	test_new_web_client
			-- Test creating web client.
		local
			api: APP_API
		do
			create api.make
			check client_created: api.new_web_client /= Void end
		end

	test_web_client_direct_access
			-- Test direct web client access.
		local
			api: APP_API
		do
			create api.make
			check web_client_available: api.web_client /= Void end
		end

feature -- Service Composition Tests

	test_service_features_available
			-- Test that SERVICE features are accessible via composition.
		local
			api: APP_API
		do
			create api.make
			-- Test JWT access from SERVICE via composition
			check jwt_available: api.service.new_jwt ("test-secret") /= Void end
			-- Test CORS access from SERVICE via composition
			check cors_available: api.service.new_cors /= Void end
		end

feature -- Foundation Composition Tests

	test_foundation_features_available
			-- Test that FOUNDATION features are accessible via composition.
		local
			api: APP_API
			encoded: STRING
			hash: STRING
		do
			create api.make
			-- Test Base64 from FOUNDATION via composition
			encoded := api.foundation.base64_encode ("test")
			check encoded_not_empty: not encoded.is_empty end
			-- Test SHA256 from FOUNDATION via composition
			hash := api.foundation.sha256 ("password")
			check hash_not_empty: not hash.is_empty end
		end

end
