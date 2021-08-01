use CODE_PlanB;


create table activities(
e_id INT Auto_Increment primary key,
e_pictureURL varchar(150),
e_name varchar(100) NOT NULL,
e_address varchar(100),
e_budget Decimal(10),
e_URL varchar(100),
e_personCount Decimal(10),
e_kidFriendly bool NOT NULL,
e_kidPause bool NOT NULL,
e_dogFriendly bool NOT NULL
);


insert into activities (e_pictureURL, e_name, e_address, e_budget, e_URL, e_personCount, e_kidFriendly, e_kidPause, e_dogFriendly) values
('https://upload.wikimedia.org/wikipedia/commons/a/a6/Brandenburger_Tor_abends.jpg','Brandenburger Tor', 'Pariser Platz 5, 10117 Berlin', 23, 'berlin.de', 4, true, false, true);
insert into activities (e_pictureURL, e_name, e_address, e_budget, e_URL, e_personCount, e_kidFriendly, e_kidPause, e_dogFriendly) values
('https://www.berlin.de/binaries/adressen/253459/source/1553093193/624x468/','house of weekend', 'Alexanderstraße 7, 10178 Berlin', 140, 'houseofweekend.berlin', 5, false, false, false);
insert into activities (e_pictureURL, e_name, e_address, e_budget, e_URL, e_personCount, e_kidFriendly, e_kidPause, e_dogFriendly) values
('https://tv-turm.de/wp-content/cache/thumb/a7/41e4105073d1aa7_800x0.jpg','TV-Tower Berlin', 'Panoramastraße 1A, 10118 Berlin', 20, 'tv-turm.de', 2, true, false, false);

insert into activities (e_pictureURL, e_name, e_address, e_budget, e_URL, e_personCount, e_kidFriendly, e_kidPause, e_dogFriendly) values
('https://lh5.googleusercontent.com/p/AF1QipMn72AmiA0jZMDYZxMJ3acKp70pCK6WZMLREIKa=w408-h306-k-no','Berliner Dom', 'Am Lustgarten, 10178 Berlin, Deutschland', 0, 'berlinerdom.de', 4, true, false, true);
insert into activities (e_pictureURL, e_name, e_address, e_budget, e_URL, e_personCount, e_kidFriendly, e_kidPause, e_dogFriendly) values
('https://lh5.googleusercontent.com/p/AF1QipNp-ruz-on1Vc9Rk3hx7Edns8VX-qf_goOwKcVV=w408-h272-k-no','Lustgarten', 'Unter den Linden 1, 10178 Berlin, Deutschland', 0, 'berlin.de', 5, true, false, true);
insert into activities (e_pictureURL, e_name, e_address, e_budget, e_URL, e_personCount, e_kidFriendly, e_kidPause, e_dogFriendly) values
('https://lh5.googleusercontent.com/p/AF1QipPUZroU2aolLwLzbXjfXgfHWTI3Nng4gFZwblcF=w426-h240-k-no','Berlin Dungeon', 'Spandauer Str. 2, 10178 Berlin, Deutschland', 20, 'https://www.thedungeons.com/berlin/', 2, false, false, false);
select * from activities;
