select 


--ah.customername,
--ah.communicationmethod,
--ah.leadsource,
ah.agentid,
ta.firstname,
ta.lastname,
ta.email,
ta.jobtitle,
ta.spacelicensenumber,
ta.yearsofservice,
ta.averagecustomerservicerating,
--b.destination,
--b.launchlocation,
--b.bookingcompletedate,
--b.bookingstatus,



SUM(b.packagerevenue) as packagerevenue,
SUM(b.destinationrevenue) as destinationrevenue,
SUM(b.totalrevenue) as totalrevenue,



SUM(DISTINCT ah.AssignmentID) AS total_assignments,
SUM(CASE
    WHEN b.BookingStatus = 'Confirmed' THEN 1
    ELSE 0 END) AS successful_bookings,
 
SAFE_DIVIDE(
            SUM(CASE
    WHEN b.BookingStatus = 'Confirmed' THEN 1
    ELSE 0 END), SUM(DISTINCT ah.AssignmentID))*100 AS booking_success_rate,

SUM(CASE
    WHEN b.BookingStatus = 'Confirmed' THEN b.totalrevenue
    ELSE 0 END) AS total_revenue






from assignment_history ah

LEFT JOIN space_travel_agents ta
ON ah.agentid = ta.agentid

LEFT JOIN bookings b
ON ah.assignmentid =b.assignmentid


where ah.agentid = 21

group by 1,2,3,4,5,6,7,8--,9--,10--,11,12,13--,14--,15
