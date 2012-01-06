module ApplicationHelper
  def alertbox(name)
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
