with ref_polygon
as
(
Select
'Monumen Nasional' as location_name,
ST_GEOGFROMTEXT
    (
    'POLYGON((106.82242870330809 -6.1709343255146845,106.82217121124268 -6.181131563045953,106.8327283859253 -6.180790236097018,106.82989597320557 -6.170891658836403,106.82242870330809 -6.1709343255146845))'
    ) as polygon
)

Select
location_name,
ANY_VALUE(ref_polygon.polygon) polygon, 
COUNT(DISTINCT order_no) count_bookings

from 
  <booking_dataset> booking,
   ref_polygon
where
st_intersects (ref_polygon.polygon, st_geogpoint(booking.booking_pickup_longitude, booking.booking_pickup_latitude))
and date = <date_parameter>
group by location_name
