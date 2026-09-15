Overview
 
I built this solution step by step, starting with basic data exploration and gradually developing to a best agent available for the customer.I documented the main stages through GitHub commits so the evolution of the SQL and my thought process can be followed alongside my overall comments.


Thought Process
 
I started by exploring the 3 tables and understanding what data was available before making any assumptions. I then joined all the data together to have all the info in the same row, and looked at it at an aggregated level to understand overall agent performance.

From there, I added more metrics (i.e. revenue, booking, success rates, customer ratings,etc). I then looked at more specific combinations, such as route (same launch location and destination), channel assignments (same lead source and communication method) to account for an agent's relevant experience.
 
At that point, the data was already structured well enough to support an interactive UI or dashboard using filters/parameters and dropdowns (with some additional metrics, such as location, destination,etc). However, since the assessment focused on SQL, I decided to keep the full process within SQL and take the matching logic a step further.


Match Score

The final score is weighted as follows: 100% match_score = 40% route success + 25% customer rate + 20% revenue perofrmance + 10% channel success + 5% years of service
Metrics with different scales were normalized to make them comparable before calculating the final score.


Customer Input
 
Since the environment I used was BigQuery based did not have an easy way to capture live customer input, I created a small "customer_input" table and used a "CROSS JOIN" to simulate it.
Changing values such as destination, launch location, lead source or communication method allows the same SQL to be used for different customer scenarios. And then finally ranked the output (agents) by their match score.


Disclaimer

For this assignment I was limited by the SQL tool for customer input, clearly for final launch of this code/product, it needs revision and updates 
The weights are my personal assumptions for this assessment and could be adjusted based on business requirements and historical results of course
This solution follows the requirement of no CTEs

 
