note
	description: "Unified facade for building Eiffel applications"
	author: "Larry Rix"
	date: "$Date$"
	revision: "$Revision$"

class
	APP

inherit
	SERVICE
		rename
			make as service_make
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize app with all components.
		do
			service_make
		end

feature -- Web Server

	new_web_client: SIMPLE_WEB_CLIENT
			-- Create new web client for HTTP requests.
		do
			create Result.make
		ensure
			result_not_void: Result /= Void
		end

	new_get_request (a_url: STRING): SIMPLE_WEB_REQUEST
			-- Create new GET request for `a_url'.
		require
			url_not_void: a_url /= Void
			url_not_empty: not a_url.is_empty
		do
			create Result.make_get (a_url)
		ensure
			result_not_void: Result /= Void
		end

	new_post_request (a_url: STRING): SIMPLE_WEB_REQUEST
			-- Create new POST request for `a_url'.
		require
			url_not_void: a_url /= Void
			url_not_empty: not a_url.is_empty
		do
			create Result.make_post (a_url)
		ensure
			result_not_void: Result /= Void
		end

feature -- Alpine.js Components

	new_alpine_factory: ALPINE_FACTORY
			-- Create new Alpine.js element factory.
		do
			create Result
		ensure
			result_not_void: Result /= Void
		end

	alpine: ALPINE_FACTORY
			-- Direct access to Alpine.js factory.
		once
			create Result
		end

feature -- Direct Access (Singleton Instances)

	web_client: SIMPLE_WEB_CLIENT
			-- Direct access to web client.
		once
			create Result.make
		end

end
