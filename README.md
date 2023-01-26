# eddy-app2

Eddy-app2 is a proto-app for a label management of their artists catalog and revenues.

## Back-end performance

The seeding phase was a big part of the assignment, so performance was an important topic.
Here is some ideas I've implemented to make the best out of it :

### [FastJsonparser gem](https://github.com/anilmaurya/fast_jsonparser)
FastJsonparser is a ruby wrapper of [simdjson](https://simdjson.org/software/), a C++ parsing library for JSON.<br/>
I implemented it without effort. I tried to benchmark it but the difference was not relevant due to the small size of the `sales-report.json`.<br/>
The author benchmarked on their repo with a file 11 times bigger and is declaring in that case a 164% increase on performance comparing to the usage of JSON.parse.<br/>
Even if we don't see a difference right now, I believe it should be useful if we use bigger JSON files in the future.

### Batching
Processing data in smaller chunks of records at a time, rather than loading all the records at once, can prevent memory issues.<br/>
In ruby this simply translates to the usage of ActiveRecord method `in_batches`, or `each_slice` for an Array.

### Bulk insertion
I used [activerecord-import gem](https://github.com/zdennis/activerecord-import) to seed the sales data.<br/>
Combined with the usage of batching, this process is saving us thousands of SQL queries.<br/>
Instead of calling `Sale.create` for each JSON item, attributes are stored in an array so we can import all of them at once after each parsing batch.<br/>
For fun, I compared both methods using `Time.now`, and found that using this bulking method saved me 3 seconds on the whole seeding phase. Just for a 1mb file !

### Data aggregation in controller
The homepage currently consists of an artists table, with a summary of each type of shares they made through the sales.<br/>
This means that for each artist, we need to display their total label share, artist share, etc...<br/>
These shares are stocked in Sales, which have a relationship to Artists.<br/>
If we have to call the relationship for each share type, for each artist, it would lead to a lot of unnecessary requests.<br/>
My solution was to use the [ActiveRecord.group](https://apidock.com/rails/v4.0.2/ActiveRecord/QueryMethods/group) method.<br/>
This way, calling `.sum` for any share type will cause only one request for the whole artists list.<br/>
We're basically removing a multiplying factor. Instead of having `artists.size * sum operations` queries, we have now `1 * sum operations`

## Front-end decisions

I've decided not to implement a framework like React, but to use Tailwind CSS instead. Why ?
- I believe a full framework was overkill for the views requirement of the assignment. I managed to make the features using basic tables and filtering.
- The challenge and the fun to me was mostly about importing the data and optimizing the queries, avoid any N+1 etc..
- Setting up a JS framework from scratch on a new project can be time consuming and frustrating, with unexpected errors at any turn.
- I actually had issues related to Babel libraries when trying to configure Semantic UI, but decided it was not worth the time and confusion for the simple views I needed.

## Views
I have separated the features in two views.
- `artists/summary` : acts as the homepage. Display all shares distribution for each artist. Clicking on an artist name will send you to their catalog page.
- `artists/summary` : still acts as an index page, but to show each artists releases and tracks, with the possibility of filtering by artist name or year of release.

## Testing

I've implemented a simple funnel test file, to make sure our interface features don't broke unnoticed.<br/>
It's just checking if the homepage works, and if we can access an artist catalog through the homepage. Finally, just making sure that the filtering works.

## Ideas for future improvements

### Pagination
The samples were limited in terms of quantity, with only 2 artists and 6 tracks max per release.
If we use this app as a base to implement a lot more of data, using pagination on the tables could be very useful.

### Model complexity
`sales-report.json` items have a lot of useless data for the assignment model requirements, such as : currency, publishing matters, quantity and volume..
I wonder how the application could change if I knew how these correlates with the current base !

### Data aggregation
Related to what I explained above, I wonder if there is a way to improve my method. We're still doing one request per share type, maybe there's a way to combine them ?

## Personal feedback
I enjoyed the test, it was a simple rails App with a focus on the back-end, and implicit challenges :)<br/>
I appreciate that it was explicitely not asked to implement features not currently useful, such as login or permissions.<br/>
I have worked it through multiple short sessions day-to-day.
