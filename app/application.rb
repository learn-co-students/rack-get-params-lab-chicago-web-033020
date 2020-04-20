class Application

  @@items = ["Apples","Carrots","Pears"]
  #Create a new class array called @@cart to hold any items in your cart
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
  #Create a new route called /add that takes in a GET param with the key item.
  #This should check to see if that item is in @@items and then add it to the cart if it is.
  #Otherwise give an error
    elsif req.path.match(/add/)
      search_term = req.params["item"]
      if handle_search(search_term) == "#{search_term} is one of our items"
        @@cart << search_term
        resp.write "added #{search_term}"
      else
        resp.write "We don't have that item"
      end
  #Create a new route called /cart to show the items in your cart
    elsif req.path.match(/cart/)
      if @@cart.length > 0
        @@cart.each { |item| resp.write "#{item}\n" }
      else
        resp.write "Your cart is empty"
      end
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end
