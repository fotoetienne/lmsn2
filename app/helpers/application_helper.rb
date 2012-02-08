module ApplicationHelper
  def alertbox(name)
    if mobile?
      "ui-bar ui-bar-e" 
    else
      if name == :alert or name == :error
        "alert-box error" #red
      elsif name == :notice
        "alert-box success" #green
      elsif name == :yellow
        "alert-box warning" #yellow
      else
        "alert-box" #grey
      end
    end
  end

  def logo
    image_tag("logo.jpg", :alt => "Let Me Sing Now, llc", :class => "round")
  end

  # Return a title on a per-page basis.
  def title
    base_title = "Let Me Sing Now"
    if @title.nil?
      base_title+', llc'
    else
      "#{base_title} | #{@title}"
    end
  end

end

