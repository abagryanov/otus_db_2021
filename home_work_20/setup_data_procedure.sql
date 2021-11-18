delimiter $$

create procedure setupData()
begin
    declare finished int default 0;
    declare currentTitle varchar(100) default "";
    declare currentFirstName varchar(100) default "";
    declare currentLastName varchar(100) default "";
    declare currentCorrespondenceLanguage varchar(100) default "";
    declare currentBirthDate varchar(100) default "";
    declare currentGender varchar(100) default "";
    declare currentMaritalStatus varchar(100) default "";
    declare currentCountry varchar(100) default "";
    declare currentPostalCode varchar(100) default "";
    declare currentRegion varchar(100) default "";
    declare currentCity varchar(100) default "";
    declare currentStreet varchar(100) default "";
    declare currentBuildingNumber varchar(100) default "";
    declare curPersons
        cursor for
        select title,
               first_name,
               last_name,
               correspondence_language,
               birth_date,
               gender,
               marital_status,
               country,
               postal_code,
               region,
               city,
               street,
               building_number
        from customers.csv_table;
    declare continue handler
        for not found set finished = 1;
    declare exit handler for sqlexception
        begin
            rollback;
        end;
    start transaction;
    call setupTitleDictionary();
    call setupGenderDictionary();
    call setupLanguageDictionary();
    call setupMaritalStatusDictionary();
    call setupCountryDictionary();

    open curPersons;
    getPersons:
    loop
        fetch curPersons into currentTitle, currentFirstName, currentLastName, currentCorrespondenceLanguage,
            currentBirthDate, currentGender, currentMaritalStatus, currentCountry, currentPostalCode, currentRegion,
            currentCity, currentStreet, currentBuildingNumber;
        if finished = 1 then
            leave getPersons;
        end if;
        set @countryId = null;
        if (currentCountry != "") then
            select country_id into @countryId from customers.country where name = currentCountry;
        end if;
        insert into customers.location(postal_code, city, region, street, building_number, country_id)
        values (currentPostalCode, currentCity, currentRegion, currentStreet, currentBuildingNumber, @countryId);
        set @locationId = last_insert_id();
        set @languageId = null;
        if (currentCorrespondenceLanguage != "") then
            select language_id into @languageId from customers.language where name = currentCorrespondenceLanguage;
        end if;
        set @genderId = null;
        if (currentGender != "") then
            select gender_id into @genderId from customers.gender where name = currentGender;
        end if;
        set @titleId = null;
        if (currentTitle != "") then
            select title_id into @titleId from customers.title where name = currentTitle;
        end if;
        set @maritalStatusId = null;
        if (currentMaritalStatus != "") then
            select marital_status_id into @maritalStatusId from customers.marital_status where name = currentMaritalStatus;
        end if;
        set @birthDate = null;
        if (currentBirthDate != "") then
            set @birthDate = currentBirthDate;
        end if;
        insert into customers.customer(first_name, last_name, birth_date, correspondence_language_id, gender_id, location_id,
                                   marital_status_id, title_id)
        values (currentFirstName, currentLastName, @birthDate, @languageId, @genderId, @locationId,
                @maritalStatusId, @titleId);
    end loop getPersons;
    commit;

end $$

create procedure setupTitleDictionary()
begin
    declare finished int default 0;
    declare currentTitle varchar(100) default "";
    declare curTitles
        cursor for
        select distinct title from customers.csv_table where title != "";
    declare continue handler
        for not found set finished = 1;

    open curTitles;
    getTitles:
    loop
        fetch curTitles into currentTitle;
        if finished = 1 then
            leave getTitles;
        end if;
        insert into customers.title(name) values (currentTitle);
    end loop getTitles;
    close curTitles;
end $$

create procedure setupGenderDictionary()
begin
    declare finished int default 0;
    declare currentGender varchar(100) default "";
    declare curGenders
        cursor for
        select distinct gender from customers.csv_table where gender != "";
    declare continue handler
        for not found set finished = 1;

    open curGenders;
    getGenders:
    loop
        fetch curGenders into currentGender;
        if finished = 1 then
            leave getGenders;
        end if;
        insert into customers.gender(name) values (currentGender);
    end loop getGenders;
    close curGenders;
end $$

create procedure setupLanguageDictionary()
begin
    declare finished int default 0;
    declare currentLanguage varchar(100) default "";
    declare curLanguages
        cursor for
        select distinct correspondence_language from customers.csv_table where correspondence_language != "";
    declare continue handler
        for not found set finished = 1;

    open curLanguages;
    getLanguages:
    loop
        fetch curLanguages into currentLanguage;
        if finished = 1 then
            leave getLanguages;
        end if;
        insert into customers.language(name) values (currentLanguage);
    end loop getLanguages;
    close curLanguages;
end $$

create procedure setupMaritalStatusDictionary()
begin
    declare finished int default 0;
    declare currentMaritalStatus varchar(100) default "";
    declare curMaritalStatuses
        cursor for
        select distinct marital_status from customers.csv_table where marital_status != '';
    declare continue handler
        for not found set finished = 1;

    open curMaritalStatuses;
    getMaritalStatuses:
    loop
        fetch curMaritalStatuses into currentMaritalStatus;
        if finished = 1 then
            leave getMaritalStatuses;
        end if;
        insert into customers.marital_status(name) values (currentMaritalStatus);
    end loop getMaritalStatuses;
    close curMaritalStatuses;
end $$

create procedure setupCountryDictionary()
begin
    declare finished int default 0;
    declare currentCountry varchar(100) default "";
    declare curCountries
        cursor for
        select distinct country from customers.csv_table where country != '';
    declare continue handler
        for not found set finished = 1;

    open curCountries;
    getCountries:
    loop
        fetch curCountries into currentCountry;
        if finished = 1 then
            leave getCountries;
        end if;
        insert into customers.country(name) values (currentCountry);
    end loop getCountries;
    close curCountries;
end $$

delimiter ;