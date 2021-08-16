/*
This program is developed to provide insights  into the music industry
*/

--Which tracks appeared in the most playlists? how many playlist did they appear in?

SELECT Name, Count(Name) AS "# of Playlists Song Appears in"
FROM playlist_track
JOIN tracks
	ON playlist_track.TrackId = tracks.TrackId
GROUP BY name
ORDER BY Count(Name) DESC
;

--Tracks that generated the most revenue

SELECT name,
	it.UnitPrice,
	Quantity,
	COUNT(quantity) AS "Total Bought",
	(COUNT(Quantity) * it.UnitPrice) AS "Revenue"
FROM tracks t
JOIN invoice_items it
	ON t.TrackId = it.TrackId
GROUP BY name
ORDER BY "Revenue" DESC
;

--Albums that generated the most revenue

SELECT Title,
	artists.name AS "Artist Name",
	COUNT(quantity) AS "Tracks Bought from Album",
	(COUNT(Quantity) * it.UnitPrice) AS "Revenue from Album"
FROM tracks t
JOIN albums a
	ON t.albumId = a.AlbumId
JOIN invoice_items it
	ON t.TrackId = it.TrackId
JOIN artists
	ON a.ArtistId = artists.ArtistId
GROUP BY Title
ORDER BY "Revenue from Album" DESC
;

--Which genre generates the most revenue

SELECT g.name,
	COUNT(quantity) AS "Tracks Bought from Genre",
	(COUNT(Quantity) * it.UnitPrice) AS Revenue
FROM tracks t
JOIN  genres g
	ON t.GenreId = g.GenreId
JOIN invoice_items it
	ON t.TrackId = it.TrackId
GROUP BY g.name
ORDER BY Revenue DESC
;

--Which countries have the highest sales revenue?

SELECT InvoiceId,
	BillingCountry,
	SUM(Total) AS Revenue
FROM invoices
GROUP BY BillingCountry
ORDER BY Revenue DESC
;