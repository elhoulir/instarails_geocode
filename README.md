# README

The steps I needed to take to do this rails project:

**Initial set-up:**

Create a new rails project - my project is called **instarails_geo** 

- in the TERMINAL do

        rails new instarails_geo

- open the new project (instarails_geo) with VS-Code 

- add rspec gem into GEMFILE 

        gem 'rspec-rails', '~> 3.7', '>= 3.7.2' 
   
    This is added into the development test section).

- add devise gem into GEMFILE 
        
        gem 'devise', '~> 4.4', '>= 4.4.3'

- Then add any other gems I may need to use into GEMFILE

        gem 'geocoder'
        gem 'country_select'

- in the TERMINAL do
    
        bundle 

- then in TERMINAL, do 
    
        rails g rspec:install

- then in TERMINAL do 
    
        rails g devise:install

**Starting the project:**


- in TERMINAL enter 
        
        rails g devise User

- then in TERMINAL do 
        
        rails g model Profile first_name last_name latitude:decimal longitude:decimal user:references street_address city postcode state country_code

- then in TERMINAL do
        
- to run the server, in TERMINAL do

        rails s

    to view the page, open http://localhost:3000/ on a browser (this is the default server)
        rails db:migrate

- in /config/routes add

        get '/profile', to: 'profiles#show'
        post '/profile', to: 'profiles#create'
        get '/profile/edit', to: 'profiles#edit'

- in /app/controllers create a new controller file called 

    - profiles_controller.rb

- in profiles_controller.rb add

        class ProfilesController < ApplicationController

            def show
                #user not signed in, redirect to root
                redirect_to :root unless user_signed_in?
                @profile = Profile.find(user: current_user)
                # @profile = current_user.profile
                # @profile = Profile.find(current_user.profile.id)
            end

            def edit
                @profile = Profile.find_or_initialize_by(user: current_user)
            end

            def create
                @profile = Profile.new(profile_params)
                @profile.user = current_user

                if @profile.save
                    flash[:notice] = 'Profile created'
                    redirect_to root_path
                
                else
                    flash[:alert] = 'Could not save profile'
                    redirect_to :back
                end
                
            end

            private
            def profile_params
                params.require(:profile).permit
                ([
                    :first_name,
                    :last_name,
                    :street_address,
                    :city,
                    :state,
                    :postcode,
                    :country_code
                ])
                end
         end

    this can be updated and edited throughout the project

- in app/views, create a folder called 'profiles', and in that folder add two files:
    - edit.html.erb
    - show.html.erb

- in TERMINAL do

        rails g controller Pages home

    this controller helps us route to the homepage

- in app/controllers, open applications_controller file and add the following methods to the class
        
        before_action :authenticate_user! 

        def after_sign_in_path_for(user)
            profile_edit_path if user.profile.nil?
        end


- in the routes.rb file add 

         root 'pages#home'

- in **user.rb** controller add the following method

        has_one :profile

- in the **edit.html.erb** file, make a new form by adding the following:

        <%= form_with(model: @profile, url: profile_path, local: true) do |f| %>
    
            <p>
                <%= f.label :first_name %>
                <%= f.text_field :first_name %>
            </p>
        
            <p>
                <%= f.label :last_name %>
                <%= f.text_field :last_name %>
            </p>
        
            <p>
                <%= f.label :street_address %>
                <%= f.text_field :street_address %>
            </p>
            
            <p>
                <%= f.label :city %>
                <%= f.text_field :city %>
            </p>
        
            <p>
                <%= f.label :state %>
                <%= f.text_field :state %>
            </p>
            
            <p>
                <%= f.label :postcode %>
                <%= f.text_field :postcode %>
            </p>
            
            <p>
                <%= f.label :country_code %>
                <%= f.country_select :country_code, priority_countries: ['AU', 'NZ']  %>
            </p>

            <p>
                <%=%>
            </p>

        <% end %>

- in **profile.rb** model add
   
         class Profile < ApplicationRecord  
            belongs_to :user
            validates(
                :first_name,
                :last_name,
                :street_address,
                :city,
                :state,
                :postcode,
                :country_code,
                presence: true ) 
        
            geocoded_by :full_address
            after_validation :geocode
                    
                def full_address
                    "#{street_address}, #{city}, #{state}, #{postcode}, #{country_code}"
                end
            end
    this is to add the geocode functionality for the app

