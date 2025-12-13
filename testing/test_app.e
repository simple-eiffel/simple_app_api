note
	description: "Test application for simple_app_api"
	author: "Larry Rix"

class
	TEST_APP

create
	make

feature {NONE} -- Initialization

	make
			-- Run tests.
		local
			tests: LIB_TESTS
		do
			create tests
			io.put_string ("simple_app_api test runner%N")
			io.put_string ("====================================%N%N")

			passed := 0
			failed := 0

			-- Alpine Tests
			io.put_string ("Alpine.js Tests%N")
			io.put_string ("---------------%N")
			run_test (agent tests.test_new_alpine_factory, "test_new_alpine_factory")
			run_test (agent tests.test_alpine_direct_access, "test_alpine_direct_access")

			-- Web Client Tests
			io.put_string ("%NWeb Client Tests%N")
			io.put_string ("----------------%N")
			run_test (agent tests.test_new_web_client, "test_new_web_client")
			run_test (agent tests.test_web_client_direct_access, "test_web_client_direct_access")

			-- Service Inheritance Tests
			io.put_string ("%NService Inheritance Tests%N")
			io.put_string ("-------------------------%N")
			run_test (agent tests.test_service_features_available, "test_service_features_available")

			-- Foundation Inheritance Tests
			io.put_string ("%NFoundation Inheritance Tests%N")
			io.put_string ("----------------------------%N")
			run_test (agent tests.test_foundation_features_available, "test_foundation_features_available")

			io.put_string ("%N====================================%N")
			io.put_string ("Results: " + passed.out + " passed, " + failed.out + " failed%N")

			if failed > 0 then
				io.put_string ("TESTS FAILED%N")
			else
				io.put_string ("ALL TESTS PASSED%N")
			end
		end

feature {NONE} -- Implementation

	passed: INTEGER
	failed: INTEGER

	run_test (a_test: PROCEDURE; a_name: STRING)
			-- Run a single test and update counters.
		local
			l_retried: BOOLEAN
		do
			if not l_retried then
				a_test.call (Void)
				io.put_string ("  PASS: " + a_name + "%N")
				passed := passed + 1
			end
		rescue
			io.put_string ("  FAIL: " + a_name + "%N")
			failed := failed + 1
			l_retried := True
			retry
		end

end
