"1. Define the Employee class"
Object subclass: Employee [

    | id name role salary |

    "Class method to create and initialize a new Employee"
    Employee class >> id: anId name: aName role: aRole salary: aSalary [
        ^ self new initId: anId name: aName role: aRole salary: aSalary
    ]

    initId: anId name: aName role: aRole salary: aSalary [
        id := anId.
        name := aName.
        role := aRole.
        salary := aSalary.
    ]

    "Getters"
    id [ ^ id ]
    name [ ^ name ]
    role [ ^ role ]
    salary [ ^ salary ]

    "Format employee details as a string"
    details [
        ^ 'ID: ', id printString, ' | Name: ', name, ' | Role: ', role, ' | Salary: ', salary printString
    ]
]

"2. Define the EmployeeDatabase class"
Object subclass: EmployeeDatabase [

    | records |

    EmployeeDatabase class >> new [
        ^ super new initialize
    ]

    initialize [
        records := Dictionary new.
    ]

    addEmployee: anEmployee [
        records at: (anEmployee id) put: anEmployee.
    ]

    findById: anId [
        ^ records at: anId ifAbsent: [ nil ]
    ]

    removeById: anId [
        records removeKey: anId ifAbsent: [ 
            Transcript show: 'Employee ID ', anId printString, ' not found.'; cr 
        ].
    ]

    printAll [
        Transcript show: '--- Employee Directory ---'; cr.
        records do: [ :emp |
            Transcript show: (emp details); cr.
        ].
        Transcript show: '--------------------------'; cr.
    ]
]

"3. Main execution block"

| db emp1 emp2 emp3 found |

db := EmployeeDatabase new.

"Create employees"
emp1 := Employee id: 101 name: 'Aarav Sharma' role: 'Developer' salary: 85000.
emp2 := Employee id: 102 name: 'Priya Nair' role: 'Designer' salary: 78000.
emp3 := Employee id: 103 name: 'Rohan Verma' role: 'Manager' salary: 95000.

"Add to database"
db addEmployee: emp1.
db addEmployee: emp2.
db addEmployee: emp3.

"Display all records"
db printAll.

"Search for an employee"
found := db findById: 102.
found notNil 
    ifTrue: [ Transcript show: 'Found -> ', (found details); cr ]
    ifFalse: [ Transcript show: 'Employee not found.'; cr ].

"Remove an employee and print updated list"
Transcript show: 'Removing ID 101...'; cr.
db removeById: 101.
db printAll.
