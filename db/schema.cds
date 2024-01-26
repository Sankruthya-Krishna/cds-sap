namespace com.satinfotech.studentdb;

entity Student{
    @title:'Student ID'
    key st_id:String(10);
    @title:'Gender'
    gender:Association to Gender;
    @title:'First Name'
    first_name:String(10) @mandatory;
    @title:'Last Name'
    last_name:String(10) @mandatory;
    @title:'Email ID'
    email_id:String(40) @mandatory;
    @title:'PAN No'
    pan_no:String(10);
    @title:'DOB'
    dob: Date @mandatory;
    @title:'Age'
    virtual age:Integer @Core.Computed;

}

// @mandatory makes the input mandatory
//if the schema structure is changed redeploy usingcds deploy --to sqlite command
entity Gender {
    @title:'code'
    key code: String(1);
    @title:'description'
    description:String(10);
}