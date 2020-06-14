def truck_rect truck
  return [truck.x - truck.w/2,
          truck.y - truck.h/2,
          truck.w,
          truck.h]
end

def truck_hit_truck? a, b
  return (truck_rect a).intersect_rect? (truck_rect b)
end
