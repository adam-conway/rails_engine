module Intelligence

  def intelligence_router(request, params = {})
    original_path = find_original_path(request)
    case original_path
    when "revenue" then single_merchant_revenue
    end
  end

  def find_original_path(request)
    request.env["PATH_INFO"].split('/').last
  end
end
