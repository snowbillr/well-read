module ApplicationHelper
  def active_nav_link_class(path)
    active = if path == root_path
               current_page?(path)
    else
               request.path.start_with?(path)
    end

    base_classes = "text-sm font-bold font-serif text-deep-ink hover:opacity-70 transition pb-1 border-b-2"
    active ? "#{base_classes} border-deep-ink" : "#{base_classes} border-transparent"
  end
end
