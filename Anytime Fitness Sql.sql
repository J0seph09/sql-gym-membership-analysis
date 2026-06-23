
-- Analysis of Anytime Fitness-style gym memberships in Lacey Township, NJ

create table plans (
    plan_id int primary key auto_increment,
    plan_name varchar(100) not null, 
    monthly_price decimal(8,2) not null
);

create table customers (
    customer_id int primary key auto_increment,
    first_name varchar(50) not null,
    last_name varchar(50) not null,
    signup_date date,
    referred_by int,
    foreign key (referred_by) references customers(customer_id)
);

create table memberships (
    memberships_id int primary key auto_increment,
    customer_id int,
    plan_id int,
    start_date date,
    end_date date,
    status varchar(50),
    foreign key (customer_id) references customers(customer_id),
    foreign key (plan_id) references plans(plan_id)
);

create table monthly_dues (
    monthly_dues_id int primary key auto_increment,
    memberships_id int,
    billing_month date, -- billed once a month on the first day of the month
    amount decimal(8,2) not null,
    status varchar(10), -- paid or failed
    foreign key (memberships_id) references memberships(memberships_id)
); 

-- Simulated gym membership plans based on Anytime Fitness-style pricing

insert into plans (plan_name, monthly_price) values 
('Student', 35.00),
('Regular', 40.00),
('Pro', 48.00),
('Senior', 29.00);

-- Anonymized sample customer data from sample customers who go to the gym

insert into customers (first_name, last_name, signup_date, referred_by) values
('Ava', 'Smith', '2023-11-05', null),
('Mike', 'Marcus', '2023-12-10', 1),          -- referred by Ava
('Sofia', 'Castellano', '2024-01-15', null),
('Derek', 'Newman', '2024-01-20', 3),         -- referred by Sofia
('Lena', 'Petrov', '2024-02-08', null),
('Tomas', 'Johnson', '2024-02-25', 1),        -- referred by Ava
('Joseph', 'Meireles', '2024-03-23', null),
('Caroline', 'Bond', '2025-10-03', 7);        -- referred by Joseph

insert into memberships (customer_id, plan_id, start_date, end_date, status) values
(1, 3, '2023-11-05', null, 'active'),
(2, 1, '2023-12-10', '2024-09-23', 'churned'),
(3, 3, '2024-01-15', null, 'active'),
(4, 1, '2024-01-20', '2024-03-20', 'churned'), -- left after about 2 months
(5, 2, '2024-02-08', null, 'active'),
(6, 1, '2024-02-25', null, 'active'),
(7, 1, '2024-03-23', null, 'active'),
(8, 1, '2025-10-03', null, 'active');

-- Sample monthly payments

insert into monthly_dues (memberships_id, billing_month, amount, status) values
(1, '2024-01-01', 48.00, 'paid'),
(1, '2024-02-01', 48.00, 'paid'),
(1, '2024-03-01', 48.00, 'failed'),
(1, '2024-04-01', 48.00, 'paid'),
(1, '2024-05-01', 48.00, 'paid'),
(1, '2024-06-01', 48.00, 'paid'),
(1, '2024-07-01', 48.00, 'paid'),
(1, '2024-08-01', 48.00, 'paid'),

(2, '2024-01-01', 35.00, 'paid'),
(2, '2024-02-01', 35.00, 'paid'),   
(2, '2024-03-01', 35.00, 'paid'),
(2, '2024-04-01', 35.00, 'paid'),
(2, '2024-05-01', 35.00, 'paid'),
(2, '2024-06-01', 35.00, 'paid'),
(2, '2024-07-01', 35.00, 'paid'),
(2, '2024-08-01', 35.00, 'paid'), -- churned after this

(3, '2024-01-01', 48.00, 'paid'),
(3, '2024-02-01', 48.00, 'paid'),
(3, '2024-03-01', 48.00, 'paid'),
(3, '2024-04-01', 48.00, 'paid'),
(3, '2024-05-01', 48.00, 'failed'),
(3, '2024-06-01', 48.00, 'paid'),
(3, '2024-07-01', 48.00, 'paid'),
(3, '2024-08-01', 48.00, 'paid'),

(4, '2024-01-01', 35.00, 'paid'),
(4, '2024-02-01', 35.00, 'paid'),
(4, '2024-03-01', 35.00, 'paid'), -- churned after this

(5, '2024-02-01', 40.00, 'paid'),
(5, '2024-03-01', 40.00, 'paid'),
(5, '2024-04-01', 40.00, 'paid'),
(5, '2024-05-01', 40.00, 'paid'),
(5, '2024-06-01', 40.00, 'paid'),
(5, '2024-07-01', 40.00, 'paid'),
(5, '2024-08-01', 40.00, 'paid'),

(6, '2024-02-01', 35.00, 'paid'),
(6, '2024-03-01', 35.00, 'paid'),
(6, '2024-04-01', 35.00, 'paid'),
(6, '2024-05-01', 35.00, 'failed'),
(6, '2024-06-01', 35.00, 'paid'),
(6, '2024-07-01', 35.00, 'paid'),
(6, '2024-08-01', 35.00, 'paid'),

(7, '2024-04-01', 35.00, 'paid'),
(7, '2024-05-01', 35.00, 'paid'),
(7, '2024-06-01', 35.00, 'paid'),
(7, '2024-07-01', 35.00, 'paid'),
(7, '2024-08-01', 35.00, 'paid'),

(8, '2025-10-01', 35.00, 'paid'),
(8, '2025-11-01', 35.00, 'failed'),
(8, '2025-12-01', 35.00, 'paid'),
(8, '2026-01-01', 35.00, 'paid'),
(8, '2026-02-01', 35.00, 'paid'),
(8, '2026-03-01', 35.00, 'paid'),
(8, '2026-04-01', 35.00, 'paid'),
(8, '2026-05-01', 35.00, 'paid');


-- Pivot table: monthly revenue by plan type
-- SUM(CASE WHEN ...) turns rows into columns.

select
    m.billing_month,
    sum(case when p.plan_name = 'Student' then m.amount else 0 end) as student_rev,
    sum(case when p.plan_name = 'Regular' then m.amount else 0 end) as regular_rev,
    sum(case when p.plan_name = 'Pro' then m.amount else 0 end) as pro_rev,
    sum(case when p.plan_name = 'Senior' then m.amount else 0 end) as senior_rev,
    sum(m.amount) as total_rev
from monthly_dues m
join memberships i on m.memberships_id = i.memberships_id
join plans p on i.plan_id = p.plan_id
where m.status = 'paid'
group by m.billing_month
order by m.billing_month;


-- Self-join: who referred whom

select 
    new_cust.first_name as new_customer,
    referrer.first_name as referred_by
from customers new_cust
join customers referrer 
    on new_cust.referred_by = referrer.customer_id;


-- 3-month moving average of revenue

with monthly_rev as (
    select 
        billing_month,
        sum(amount) as revenue
    from monthly_dues
    where status = 'paid'
    group by billing_month
)
select 
    billing_month, 
    revenue, 
    avg(revenue) over (
        order by billing_month
        rows between 2 preceding and current row 
    ) as moving_avg_3mo
from monthly_rev
order by billing_month; 


-- Date math: average customer lifetime by active vs churned status
-- datediff gives days between two dates.

select 
    status,
    count(*) as num_subs,
    round(avg(datediff(coalesce(end_date, curdate()), start_date))) as avg_days_active
from memberships
group by status;


-- Monthly recurring revenue

select 
    billing_month,
    sum(amount) as mrr
from monthly_dues
where status = 'paid'
group by billing_month
order by billing_month;


-- Failed payment rate

select 
    billing_month,
    count(*) as total_bills,
    sum(case when status = 'failed' then 1 else 0 end) as failed_bills,
    round(
        100.0 * sum(case when status = 'failed' then 1 else 0 end) / count(*), 
        2) as failed_rate
from monthly_dues
group by billing_month
order by billing_month;


-- Revenue by plan

select 
    p.plan_name, 
    sum(m.amount) as total_rev
from monthly_dues m 
join memberships ms on m.memberships_id = ms.memberships_id 
join plans p on ms.plan_id = p.plan_id 
where m.status = 'paid'
group by p.plan_name
order by total_rev desc; 


-- Churn rate

select 
    round(
        100.0 * sum(case when status = 'churned' then 1 else 0 end) / count(*), 
        2
    ) as churn_rate
from memberships;


--- customer lifetime value by customer

select 
    c.customer_id,
    concat(c.first_name, ' ', c.last_name) as customer_name,
    p.plan_name,
    ms.status,
    sum(case when md.status = 'paid' then md.amount else 0 end) as lifetime_rev,
    count(case when md.status = 'paid' then 1 end) as paid_months,
    count(case when md.status = 'failed' then 1 end) as failed_months
from customers c
join memberships ms on c.customer_id = ms.customer_id
join plans p on ms.plan_id = p.plan_id
left join monthly_dues md on ms.memberships_id = md.memberships_id
group by c.customer_id, customer_name, p.plan_name, ms.status
order by lifetime_rev desc;