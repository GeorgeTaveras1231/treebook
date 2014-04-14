module NavbarHelper
	def active? path
		request.fullpath == path ? "active" : nil
	end

	def nav_button name, path
    if block_given?
      content_tag :li, class: "dropdown" do
        html = content_tag :a, href: "", class: "dropdown-toggle", data: { toggle: "dropdown" } do
         raw "#{name} #{content_tag :span, '', class: 'caret'}"
        end
        html += dropdown { yield }
        html
      end
    else
      content_tag :li, class: "#{active? path}" do
        link_to name, path
      end
    end
	end

  def menu_button name, path, opts={}
    #assumes menu buttons are inside a ul
    link_opts = opts[:link] || {}
    li_opts = opts[:container] || {}
    content_tag :li, li_opts do 
      link_to name, path, link_opts
    end 
  end

  def dropdown type=:menu,opts={}
    default = {
      class: "dropdown-#{type}"
    }.merge opts

    content_tag :ul, default do
      yield
    end
  end

  def divider type=:span
    content_tag type, "",class: "divider"
  end

end