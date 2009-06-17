module PortfolioHelper
  
  def editable_content(options)
    options[:content] = { :element => 'span' }.merge(options[:content])
    options[:url] = {}.merge(options[:url])
    options[:ajax] = { :okText => "'Save'", :cancelText => "'Cancel'"}.merge(options[:ajax] || {})
    script = Array.new
    script << "new Ajax.InPlaceEditor("
    script << "  '#{options[:content][:options][:id]}',"
    script << "  '#{url_for(options[:url])}',"
    script << "  {"
    script << options[:ajax].map{ |key, value| "#{key.to_s}: #{value}" }.join(", ")
    script << "  }"
    script << ")"

    content_tag(
      options[:content][:element],
      options[:content][:text],
      options[:content][:options]
    ) + javascript_tag( script.join("\n") )
  end

  # Builds an activity message for a given object if supported
  def activity_message_for(object)
    case object.class.name
      when 'Achievement'
        link_to truncate("Achievement: #{object.description}", 100), :controller => 'Portfolio::Achievement', :action => "show", :achievement_id => object.id
      when 'Activity'
        link_to "Activity: #{object.description}", :controller => 'Portfolio::Activity', :action => "show", :activity_id => object.id
      when 'Experience'
        link_to "Experience: #{object.role}", :controller => 'Portfolio::Experience', :action => "show", :experience_id => object.id
      when 'Institution'
        link_to "Education: #{object.name}", { :controller => 'Portfolio::Education', :action => "index" }
      when 'Link'
        link_to "Link: #{object.name}", { :controller => 'Portfolio::Links', :action => 'index' }
      when 'Meeting'
        link_to "Meeting: #{object.attendees}", :controller => 'Portfolio::Meeting', :action => "show", :meeting_id => object.id
      when 'Post'
        link_to "Blog Post: #{object.title}", :controller => 'Portfolio::Posts', :action => "show", :post_id => object.id
    end
  end 

  
    
end
