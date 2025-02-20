-- Switch to the correct database
USE StudentGrades;
GO

-- Create Students table
CREATE TABLE Students (
    student_id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    class VARCHAR(50) NOT NULL
);
GO

-- Create Subjects table
CREATE TABLE Subjects (
    subject_id INT IDENTITY(1,1) PRIMARY KEY,
    subject_name VARCHAR(100) NOT NULL
);
GO

-- Create Grades table
CREATE TABLE Grades (
    grade_id INT IDENTITY(1,1) PRIMARY KEY,
    student_id INT,
    subject_id INT,
    score INT CHECK (score BETWEEN 0 AND 100),
    FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (subject_id) REFERENCES Subjects(subject_id) ON DELETE CASCADE
);
GO

-- Insert sample data
INSERT INTO Students (name, class) VALUES
('Ali Khan', '10th'),
('Sara Ahmed', '10th'),
('Bilal Hussain', '10th');
GO

INSERT INTO Subjects (subject_name) VALUES
('Mathematics'),
('Science'),
('English');
GO

INSERT INTO Grades (student_id, subject_id, score) VALUES
(1, 1, 85),
(1, 2, 90),
(1, 3, 78),
(2, 1, 88),
(2, 2, 76),
(2, 3, 92),
(3, 1, 95),
(3, 2, 89),
(3, 3, 85);
GO

-- Generate reports
-- 1. Average Grade per Student
SELECT s.name, AVG(g.score) AS average_score
FROM Grades g
JOIN Students s ON g.student_id = s.student_id
GROUP BY s.name;
GO

-- 2. Highest Scores in Each Subject
SELECT sub.subject_name, s.name, g.score
FROM Grades g
JOIN Students s ON g.student_id = s.student_id
JOIN Subjects sub ON g.subject_id = sub.subject_id
WHERE g.score = (
    SELECT MAX(score)
    FROM Grades
    WHERE subject_id = g.subject_id
);
GO

-- 3. Subject Performance (Average Score per Subject)
SELECT sub.subject_name, AVG(g.score) AS average_score
FROM Grades g
JOIN Subjects sub ON g.subject_id = sub.subject_id
GROUP BY sub.subject_name;
GO
