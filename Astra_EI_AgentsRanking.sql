select 


--ah.customername,
--ah.communicationmethod,
--ah.leadsource,
s.agentid,
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






FROM space_travel_agents ta



LEFT JOIN

(



SELECT
ah.agentid,
 
COUNT(DISTINCT ah.assignmentid) AS total_assignments,
 
SAFE_DIVIDE(
COUNT(DISTINCT CASE WHEN b.bookingstatus = 'Confirmed' THEN ah.assignmentid END),COUNT(DISTINCT ah.assignmentid)) * 100 AS overall_success_rate,
 
AVG(CASE WHEN b.bookingstatus = 'Confirmed' THEN b.totalrevenue END) AS overall_avg_revenue,
 
 
 -- # of assignments with same launch and destination
COUNT(DISTINCT CASE
                WHEN b.destination = ci.input_destination AND b.launchlocation = ci.input_launchlocation
                THEN b.assignmentid END) AS route_assignments,
 
 -- # of CONFIRMED assignments with same launch and destination /  -- # of assignments with same launch and destination
SAFE_DIVIDE(
COUNT(DISTINCT CASE
                WHEN b.destination = ci.input_destination AND b.launchlocation = ci.input_launchlocation AND b.bookingstatus = 'Confirmed' THEN b.assignmentid END),
NULLIF(COUNT(DISTINCT CASE
                WHEN b.destination = ci.input_destination AND b.launchlocation = ci.input_launchlocation THEN b.assignmentid END), 0)) * 100 AS route_success_rate,
 
 
  -- # of assignments with same launch and destination - AVG REVENUE
AVG(CASE
    WHEN b.destination = ci.input_destination AND b.launchlocation = ci.input_launchlocation AND b.bookingstatus = 'Confirmed' THEN b.totalrevenue END) AS route_avg_revenue,
 
 
 -- # of assignments with same leadsource and communication method
COUNT(DISTINCT CASE
                WHEN ah.communicationmethod = ci.input_communicationmethod AND ah.leadsource = ci.input_leadsource THEN b.assignmentid END) AS channel_assignments,
 
 
  -- # of COMFIRMED assignments with same leadsource and communication method /  -- # of assignments with same leadsource and communication method
SAFE_DIVIDE(
COUNT(DISTINCT CASE
                WHEN ah.communicationmethod = ci.input_communicationmethod AND ah.leadsource = ci.input_leadsource AND b.bookingstatus = 'Confirmed' THEN b.assignmentid END),
NULLIF(COUNT(DISTINCT CASE
                      WHEN ah.communicationmethod = ci.input_communicationmethod AND ah.leadsource = ci.input_leadsource THEN b.assignmentid END), 0)) * 100 AS channel_success_rate
 
 





FROM assignment_history ah
CROSS JOIN 
(
select 
'Niloo Torabifard' as input_customername,
'Text' as input_communicationmethod,
'Organic' as input_leadsource,
'Venus' as input_destination,
'New York Orbital Gateway' as input_launchlocation
) ci--customer_input



LEFT JOIN bookings b ON ah.assignmentid = b.assignmentid
GROUP BY ah.agentid
) s--stats
ON ta.agentid = s.agentid
