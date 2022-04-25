SELECT e.emp_no, 
	e.first_name, 
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as t
	ON (e.emp_no=t.emp_no)	
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (r.emp_no) r.emp_no, 
	r.first_name, 
	r.last_name,
	r.title
INTO unique_titles
FROM retirement_titles as r
WHERE (to_date = '9999-01-01')
ORDER BY emp_no, to_date DESC;

-- Retrieve number of titles from the Unique Titles table
SELECT COUNT(u.title), u.title
INTO retiring_titles
FROM unique_titles as u
GROUP BY u.title
ORDER BY count(u.title) DESC;

-- Mentorship Eligibility program
SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name, 
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentorship_eligibility
FROM employees as e 
INNER JOIN dept_emp as de
	ON (e.emp_no=de.emp_no)
INNER JOIN titles as t
	ON (e.emp_no=t.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no;


-- EXTRA QUERIES AND TABLES FOR ANALYSIS


-- Retrieve number of titles from the Mentorship Program
SELECT COUNT(me.emp_no), me.title
FROM mentorship_eligibility as me
GROUP BY me.title
ORDER BY count(me.title) DESC;

-- Retrieve number of genders from the Employees table
SELECT COUNT(e.emp_no), e.gender
FROM employees as e
GROUP BY e.gender
ORDER BY count(e.gender) DESC;

-- Retrieve the departments from the Mentorship Program
SELECT DISTINCT ON (me.emp_no) me.emp_no,
	de.dept_no,
	d.dept_name
INTO dept_mentorship
FROM mentorship_eligibility as me
INNER JOIN dept_emp as de
	ON (me.emp_no = de.emp_no)
INNER JOIN departments as d 
 	ON (de.dept_no = d.dept_no)
	
-- Retrieve the number of employees from each department eligible for mentorship	
SELECT COUNT(dm.emp_no), dm.dept_name
FROM dept_mentorship as dm
GROUP BY dm.dept_name
ORDER BY count(dm.dept_name) DESC;

-- Retrieve the departments from current employees
SELECT DISTINCT ON (e.emp_no) e.emp_no,
	de.dept_no,
	d.dept_name
INTO total_employees
FROM employees as e
INNER JOIN dept_emp as de
	ON (e.emp_no = de.emp_no)
INNER JOIN departments as d 
 	ON (de.dept_no = d.dept_no)
	
-- Retrieve the number of current employees in each department
SELECT COUNT(te.emp_no), te.dept_name
FROM total_employees as te
GROUP BY te.dept_name
ORDER BY count(te.dept_name) DESC;