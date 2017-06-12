module Plugins::VzaarUploader::MainHelper
  def self.included(klass)
    # klass.helper_method [:my_helper_method] rescue "" # here your methods accessible from views
  end

  # here all actions on going to active
  # you can run sql commands like this:
  # results = ActiveRecord::Base.connection.execute(query);
  # plugin: plugin model
  def vzaar_uploader_on_active(plugin)
  end

  # here all actions on going to inactive
  # plugin: plugin model
  def vzaar_uploader_on_inactive(plugin)
  end

  # hook listener to add settings link below the title of current plugin (if it is installed)
  # args: {plugin (Hash), links (Array)}
  # permit to add unlimmited of links...
  def vzaar_uploader_on_plugin_options(args)
    args[:links] << link_to('Settings', admin_plugins_vzaar_uploader_settings_path)
  end

  # hook listener to read custom videos uploaded to vzaar
  # attrs: {prefix, data}
  def vzaar_uploader_list_objects(args)
    files = current_site.get_meta(vzaar_uploader_cacke_key, {})
    puts files.inspect
    res = files[args[:prefix]] || {}
    args[:data] = args[:data].deep_merge(res)
  end

  #owen2345/secret
  # custom hook to upload videos to vzaar server
  def vzaar_uploader_before_upload(args)
    if args[:klass].class.validate_file_format(args[:key], 'video')
      key = args[:key]
      key = "/#{key}" unless key.starts_with?('/')
      # VzaarApi.client_id = 'munch-mule-hiatt'
      # VzaarApi.auth_token = 'R2p5zsS6AxNGncKrxdpw'
      VzaarApi.client_id = current_plugin.get_option('client_id')
      VzaarApi.auth_token = current_plugin.get_option('auth_token')
      file_path = args[:file].is_a?(String) ? args[:file] : args[:file].path
      video = VzaarApi::Video.create(path: file_path)
      args[:result_data] = {
          "name" => File.basename(key),
          "key" => key,
          "url" => "//view.vzaar.com/#{video.id}/player",
          "is_folder" => false,
          "size" => File.size(file_path).round(2),
          "format" => 'video',
          "deleteUrl" => '',
          "thumb" => '',
          'type' => (MIME::Types.type_for(file_path).first.content_type rescue ""),
          'created_at' => File.mtime(file_path),
          'dimension' => ''
      }
      args[:klass].cache_item(args[:result_data], nil, vzaar_uploader_cacke_key)
    end
  end
  
  def vzaar_uploader_cacke_key
    "vzaar_files_#{current_site.id}"
  end
  
  # show post form sidebar to upload featured video
  def vzaar_post_form_sidebar_custom_html(args)
    if @post_type.get_option('enable_vzaar_featured_video', false)
      args[:html] << render(plugin_view('admin/post_sidebar'))
    end
  end
  
  # add extra post type setting to enable or disable featured videos for from current post type
  def vzaar_post_type_settings_admin(args)
    args[:html] << render(plugin_view('admin/post_type_settings'))
  end
end
