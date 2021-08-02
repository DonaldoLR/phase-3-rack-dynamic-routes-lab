class Application 
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    
    if req.path.match('/items/')
      searching_item = req.path.split('/items/').last

      item_names = Item.all.map {|item| item.name}
      if item_names.include?(searching_item)
        item_found = Item.all.detect {|item| item.name = searching_item}
       
        resp.write item_found.price
      else
        resp.write 'Item not found'
        resp.status = 400
      end
    else
      resp.write 'Route not found'
      resp.status = 404
    end
    resp.finish
  end
end