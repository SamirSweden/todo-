select product_name  , price from Products 
case 
    case price > 1000 then price_category  'Expensive'
    case price  100 and < 1000  then price_category 'Medium'
    else 'cheap'
end as end_st
