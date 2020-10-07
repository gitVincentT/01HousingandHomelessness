/*
    Copyright (c) 2018 Salesforce.org
    All rights reserved.

    Redistribution and use in source and binary forms, with or without
    modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of Salesforce.org nor the names of
      its contributors may be used to endorse or promote products derived
      from this software without specific prior written permission.

    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
    "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
    LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
    FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
    COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
    INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
    BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
    LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
    CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
    LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
    ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
    POSSIBILITY OF SUCH DAMAGE.
*/
@isTest
public with sharing class UTIL_Permissions_TEST {

    // Read Only users don't have access to custom objects or fields
    private static User getReadOnlyUser() {
        return UTIL_UnitTestData_TEST.createUserWithoutInsert(UTIL_Profile.PROFILE_READ_ONLY);
    }

    // System Administrators have read/write access to custom and standard fields
    private static User getSysAdmin() {
        return UTIL_UnitTestData_TEST.createUserWithoutInsert(UTIL_Profile.SYSTEM_ADMINISTRATOR);
    }
    private static String standardObjectName = 'Contact';
    private static String standardFieldName = 'FirstName';

    @isTest
    static void readOnlyUserObjectCheckNoException() {
        System.runAs(getReadOnlyUser()) {
            System.assert(!UTIL_Permissions.canCreate(standardObjectName, false));
            System.assert(!UTIL_Permissions.canUpdate(standardObjectName, false));
            System.assert(!UTIL_Permissions.canDelete(standardObjectName, false));
            // this one is positive!
            System.assert(UTIL_Permissions.canRead(standardObjectName, false));
        }
    }


    @isTest
    static void sysAdminObjectCheckNoException() {
        System.runAs(getSysAdmin()) {
            System.assert(UTIL_Permissions.canRead(standardObjectName, false));
            System.assert(UTIL_Permissions.canCreate(standardObjectName, false));
            System.assert(UTIL_Permissions.canUpdate(standardObjectName, false));
            System.assert(UTIL_Permissions.canDelete(standardObjectName, false));
        }
    }


    @isTest
    static void readOnlyUserFieldCheckNoException() {
        System.runAs(getReadOnlyUser()) {
            DescribeFieldResult standardFieldResult =
                UTIL_Describe.getFieldDescribe(standardObjectName, standardFieldName);

            System.assert(!UTIL_Permissions.canCreate(standardObjectName, standardFieldName, false));
            System.assert(!UTIL_Permissions.canUpdate(standardObjectName, standardFieldName, false));
            System.assert(!UTIL_Permissions.canCreate(standardFieldResult, false));
            System.assert(!UTIL_Permissions.canUpdate(standardFieldResult, false));

            // these two are positive!
            System.assert(UTIL_Permissions.canRead(standardObjectName, standardFieldName, false));
            System.assert(UTIL_Permissions.canRead(standardFieldResult, false));
        }
    }


    @isTest
    static void sysAdminFieldCheckNoException() {
            DescribeFieldResult standardFieldResult =
                UTIL_Describe.getFieldDescribe(standardObjectName, standardFieldName);

            System.assert(UTIL_Permissions.canRead(standardObjectName, standardFieldName, false));
            System.assert(UTIL_Permissions.canCreate(standardObjectName, standardFieldName, false));
            System.assert(UTIL_Permissions.canUpdate(standardObjectName, standardFieldName, false));
            System.assert(UTIL_Permissions.canRead(standardFieldResult, false));
            System.assert(UTIL_Permissions.canCreate(standardFieldResult, false));
            System.assert(UTIL_Permissions.canUpdate(standardFieldResult, false));
        }
}