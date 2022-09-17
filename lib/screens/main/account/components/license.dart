/*----------------------------
Terms of use license
------------------------------------*/

import 'package:fashion_shop/config/AppConfig.dart';
import 'package:flutter/foundation.dart';

void termsOfUse() {
  LicenseRegistry.addLicense(() async* {
    yield LicenseEntryWithLineBreaks(<String>['ACustomLibrary'], '''
                            Copyright 2022 ${AppConfig.appName}.com.
                            All rights reserved.

     *The Redistributions of this source code must retain the above copyright
  notice, this list of conditions and the following disclaimer.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT 
        HOLDERS''');
  });
}

/*----------------------------
Terms of use license
------------------------------------*/

void privacyPolicy() {
  LicenseRegistry.addLicense(() async* {
    yield LicenseEntryWithLineBreaks(<String>['ACustomLibrary'], '''
                            Copyright 2022 ${AppConfig.appName}.com.
                            All rights reserved.

     *The Redistributions of this source code must retain the above copyright
  notice, this list of conditions and the following disclaimer.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT 
        HOLDERS''');
  });
}
