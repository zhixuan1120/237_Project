namespace :search_suggestions do
	desc "Generates search suggestions from users"
	task :index => :environment do
		SearchSuggestions.index_users
	end
end