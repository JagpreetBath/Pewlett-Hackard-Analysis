-- Deliverable 1: The Number of Retiring Employees by Title
-- Retirement titles
SELECT e.emp_no, 
	e.first_name, 
	e.last_name,
	ti.title,
	ti.from_date,
	ti.to_date
INTO retirement_titles
FROM employees as e
	INNER JOIN titles as ti
		ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER By emp_no;

SELECT * FROM retirement_titles;

-- Use Dictinct with Orderby to remove duplicate rows
-- Unique titles
SELECT DISTINCT ON (emp_no) emp_no, 
	first_name, 
	last_name,
	title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;

SELECT * FROM unique_titles;

-- Retiring titles 
SELECT COUNT(title) count, 
	title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC;

SELECT * FROM retiring_titles;

-- Deliverable 2: The Employees Eligible for the Mentorship Program
--Mentorship Eligibility
SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name, 
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	ti.title
INTO mentorship_eligibilty
FROM employees as e
	INNER JOIN dept_emp as de
		ON e.emp_no = de.emp_no
	INNER JOIN titles as ti
		ON (e.emp_no = ti.emp_no)
WHERE (de.to_date = '9999-01-01')
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER By e.emp_no;

SELECT * FROM mentorship_eligibilty

-- -- Deliverable 3
-- Roles that will be need to be filled 
SELECT COUNT(title) count
INTO retiring_count
FROM unique_titles
ORDER BY count DESC;

SELECT * FROM retiring_count

/* Retirement-ready employees in the departments to 
mentor the next generation of Pewlett Hackard employees */ 
SELECT COUNT(title) count
INTO mentorship_count
FROM mentorship_eligibilty
ORDER BY count DESC;

SELECT * FROM mentorship_count

SELECT COUNT(title) count,
	title
INTO mentorship_titles
FROM mentorship_eligibilty
GROUP BY title
ORDER BY count DESC;

SELECT * FROM mentorship_titles
