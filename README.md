# VzaarUploader
Vzaar video uploader plugin for Camaleon CMS. 
All videos uploaded using Camaleon Media Browser will be saved in Vzaar Server.

## Installation
* Add gem to you Gemfile
    ```
    gem 'vzaar_uploader'
    gem 'vzaar_api', git: 'git@github.com:vzaar/vzaar-api-ruby.git', branch: 'version-2.0.0-alpha'
    ```
* Install gem
    ```
    bundle install
    ```
* Active plugin in admin panel 

* Configure plugin settings to enter Vzaar API settings


## Usage
* Go to admin panel -> settings -> Content Groups

* Add/Edit a Content Group to enable Featured Video for its contents

* After enabled a featured video, this will be shown below featured image on create content

* Include video player js library in your assets
    ```
    //= require plugins/vzaar_uploader/vzaar
    ```
* In your html template render your featured video like this:
    ```
    <div class="featured_video">
      <%= video_tag @post.get_meta('featured_video') %>
    </div>
    ```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
