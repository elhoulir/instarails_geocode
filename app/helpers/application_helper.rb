module ApplicationHelper
    def google_map_image_tag(profile)
        image_tag "http://maps.googleapis.com/maps/api/staticmap?center=#{profile.latitude},#{profile.longitude}&zoom=14&size=400x400&sensor=false"
    end
end
