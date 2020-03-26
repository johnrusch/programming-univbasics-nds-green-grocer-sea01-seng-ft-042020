require 'pry'

def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  row_index = 0
  #binding.pry
  while row_index < collection.length do 
    if name == collection[row_index][:item]
      return collection[row_index]
    end
    row_index += 1 
  end

end

def consolidate_cart(cart)
  counter = 0 
  consolidated_cart = []
  while counter < cart.length do 
    new_item = find_item_by_name_in_collection(cart[counter][:item], consolidated_cart)
    if new_item
      new_item[:count] += 1 
    else 
      new_cart_item = {
        :item => cart[counter][:item],
        :price => cart[counter][:price],
        :clearance => cart[counter][:clearance],
        :count => 1
      }
      consolidated_cart.push(new_cart_item)
    end
    counter += 1 
    
  end
  consolidated_cart
end

def apply_coupons(cart, coupons)
  counter = 0 
  while counter < coupons.length do
    cart_item = find_item_by_name_in_collection(coupons[counter][:item], cart)
    coupon_item_name = "#{coupons[counter][:item]} W/COUPON"
    cart_item_with_coupon = find_item_by_name_in_collection(coupon_item_name, cart)
    if cart_item && cart_item[:count] >= coupons[counter][:num]
      if cart_item_with_coupon
        cart_item_with_coupon[:count] += coupons[counter][:num]
        cart_item[:count] -= coupons[counter][:num]
      else
        cart_item_with_coupon = {
          :item => coupon_item_name,
          :price => coupons[counter][:cost] / coupons[counter][:num],
          :clearance => cart_item[:clearance],
          :count => coupons[counter][:num]
        }
        cart.push(cart_item_with_coupon)
        cart_item[:count] -= coupons[counter][:num]
      end
    end
    counter += 1 
  end
  cart
end

def apply_clearance(cart)
  counter = 0
  while counter < cart.length do
    if cart[counter][:clearance]
      cart[counter][:price] = cart[counter][:price] - (cart[counter][:price] * 0.2)
      cart[counter][:price].round(2)
    end
    counter += 1 
  end
  cart
end

def checkout(cart, coupons)
  consolidate_cart(cart)
 
  apply_coupons(cart, coupons)
  
  apply_clearance(cart)
  
  #binding.pry
  counter = 0 
  total_cost = 0
  while counter < cart.length do
    item_price = cart[counter][:price] * cart[counter][:count]
    total_cost += item_price
    counter += 1 
  end
  if total_cost > 100
    total_cost = total_cost - (total_cost * 0.1)
  total_cost
end

# Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
 