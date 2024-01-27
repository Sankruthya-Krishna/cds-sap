
namespace com.s.studentdb;

entity Student {
   @title: 'Student ID'
   key st_id: String(5);
   @title: 'Name'
   name: String(40) @mandatory;
   @title:'GENDER'
   gender:Association to Gender;
   @title: 'Email Address'
   email: String(40) @mandatory;
   @title: 'PAN number'
   pan: String(40) @mandatory;
   @title: 'Date of birth'
   dob: Date;
   @title: 'AGE'
   virtual age: Integer @Core.Computed
}
entity Gender {
    @title: 'code'
    key code: String(1);
    @title: 'Description'
    description: String(10);
}       