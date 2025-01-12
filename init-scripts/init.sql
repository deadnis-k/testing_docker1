-- Use the target database
CREATE DATABASE IF NOT EXISTS catnip_db;
USE catnip_db;

-- Create the images table
CREATE TABLE IF NOT EXISTS images (
    id INT AUTO_INCREMENT PRIMARY KEY,
    url VARCHAR(255) NOT NULL
);

-- Insert initial data
INSERT INTO images (url) VALUES 
("https://th.bing.com/th/id/R.69bc0dd23ecbc52186c9f8226db663f6?rik=%2fkEH7eUmt7QsUQ&pid=ImgRaw&r=0"),
("https://www.gifcen.com/wp-content/uploads/2022/04/pop-cat-gif-9.gif");

-- Create the visit_counter table
CREATE TABLE IF NOT EXISTS visit_counter (
    id INT AUTO_INCREMENT PRIMARY KEY,
    visit_count INT DEFAULT 0
);

-- Add the visit_count column if it's missing (only if the column doesn't already exist)
ALTER TABLE visit_counter
ADD COLUMN IF NOT EXISTS visit_count INT DEFAULT 0;

-- Insert initial visit count if the table is empty (only if there are no records)
INSERT INTO visit_counter (visit_count) 
SELECT 0 WHERE NOT EXISTS (SELECT 1 FROM visit_counter);
