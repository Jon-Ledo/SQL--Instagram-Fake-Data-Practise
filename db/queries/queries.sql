-- QUESTIONS
-- Find the 5 oldest users
SELECT
  *
FROM
  users
ORDER BY
  created_at
LIMIT
  5;

-- what day of the week do most users register on?
SELECT
  DAYNAME(created_at) AS day,
  COUNT(*) AS total
FROM
  users
GROUP BY
  day
ORDER BY
  total;

-- Find the users who have never posted a photo
SELECT
  username,
  image_url
FROM
  users
  LEFT JOIN photos ON photos.user_id = users.id
WHERE
  image_url IS NULL;

-- Find the photo with the most likes
SELECT
  COUNT(likes.user_id) AS total,
  likes.photo_id,
  image_url
FROM
  likes
  JOIN photos ON likes.photo_id = photos.id
GROUP BY
  photo_id
ORDER BY
  total DESC
LIMIT
  1;

-- How many times does the AVERAGE user post?
-- total number of photos / total number of users
SELECT
  (
    SELECT
      COUNT(*)
    FROM
      photos
  ) / (
    SELECT
      COUNT(*)
    FROM
      users
  );

-- What are the top 5 most commonly used hashtags
SELECT
  tag_id,
  tag_name
FROM
  photo_tags
  JOIN tags ON photo_tags.tag_id = tags.id
GROUP BY
  tag_name
ORDER BY
  tag_id DESC
LIMIT
  5;

-- Find bots - users who have liked every single photo on the site
SELECT
  username,
  Count(*) AS num_likes
FROM
  users
  JOIN likes ON users.id = likes.user_id
GROUP BY
  likes.user_id
HAVING
  num_likes = (
    SELECT
      Count(*)
    FROM
      photos
  );