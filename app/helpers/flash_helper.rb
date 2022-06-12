module FlashHelper
  def css_class_for_flash(flash_key)
    case flash_key.to_sym
    when :error
      "bg-red-100 mb-5 text-red-700"
    else
      "bg-green-50 mb-5 text-green-500"
    end
  end
end
