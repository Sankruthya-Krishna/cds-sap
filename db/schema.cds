namespace com.s.studentdb;
using { managed, cuid } from '@sap/cds/common';

@assert.unique:{
    st_id:[st_id]
}
entity Student: cuid, managed {
    @title: 'Student ID'
    st_id: String(5);
    @title: 'Gender'
    gender: String(1);
    // @title: 'First Name'
    // first_name: String(40) @mandatory;
    @title: ' Name'
    name: String(40) @mandatory;
    @title: 'Email ID'
    email: String(100) @mandatory;
    @title: 'Date of Birth'
    dob: Date @mandatory;
    @title: 'PAN'
    pan:String(10) @mandatory;
    @title: 'Course'
    course: Association to Courses;
    @title: 'Age'
    virtual age: Integer @Core.Computed;
}

@cds.persistence.skip
entity Gender {
    @title: 'code'
    key code: String(1);
    @title: 'Description'
    description: String(10);
}

entity Courses : cuid, managed {
    //cuid will automatically generate uuid, where uuid will take unique key which doesnt create key always
    @title: 'Code'
    code: String(3);
    @title: 'Description'
    description: String(50);
}