Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F8067D4C5
	for <lists+linux-crypto@lfdr.de>; Thu, 26 Jan 2023 19:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjAZS6O (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 26 Jan 2023 13:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjAZS6N (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 26 Jan 2023 13:58:13 -0500
X-Greylist: delayed 606 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 26 Jan 2023 10:58:13 PST
Received: from sp12.canonet.ne.jp (sp12.canonet.ne.jp [210.134.168.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 17B031F5E1
        for <linux-crypto@vger.kernel.org>; Thu, 26 Jan 2023 10:58:13 -0800 (PST)
Received: from csp12.canonet.ne.jp (unknown [172.21.160.132])
        by sp12.canonet.ne.jp (Postfix) with ESMTP id CF0831E07C2;
        Fri, 27 Jan 2023 03:48:06 +0900 (JST)
Received: from echeck12.canonet.ne.jp ([172.21.160.122])
        by csp2 with ESMTP
        id L7I6pL7e2yh2rL7I6plIMR; Fri, 27 Jan 2023 03:48:06 +0900
X-CNT-CMCheck-Reason: "undefined", "v=2.4 cv=HvXIp2fS c=1 sm=1 tr=0
 ts=63d2cae6 cx=g_jp:t_eml p=jICtXCb1Bd4A:10 p=QA8zHFxAwLBQ4A9MkZgA:9
 p=WKcvGfCz9DfGexK3dBCb:22 a=5J8QHEf9WaWkijFsPIoXCQ==:117
 a=yr9NA9NbXb0B05yJHQEWeQ==:17 a=PlGk70OYzacA:10 a=kj9zAlcOel0A:10
 a=RvmDmJFTN0MA:10 a=x7bEGLp0ZPQA:10 a=CjuIK1q_8ugA:10 a=0iaRBTTaEecA:10
 a=xo5jKAKm-U-Zyk2_beg_:22"
X-CNT-CMCheck-Score: 100.00
Received: from echeck12.canonet.ne.jp (localhost [127.0.0.1])
        by esets.canonet.ne.jp (Postfix) with ESMTP id 804891C01EE;
        Fri, 27 Jan 2023 03:48:06 +0900 (JST)
X-Virus-Scanner: This message was checked by ESET Mail Security
        for Linux/BSD. For more information on ESET Mail Security,
        please, visit our website: http://www.eset.com/.
Received: from smtp12.canonet.ne.jp (unknown [172.21.160.102])
        by echeck12.canonet.ne.jp (Postfix) with ESMTP id 5575C1C0251;
        Fri, 27 Jan 2023 03:48:06 +0900 (JST)
Received: from daime.co.jp (webmail.canonet.ne.jp [210.134.169.250])
        by smtp12.canonet.ne.jp (Postfix) with ESMTPA id 956A315F962;
        Fri, 27 Jan 2023 03:48:05 +0900 (JST)
MIME-Version: 1.0
Message-ID: <20230126184805.00004D30.0557@daime.co.jp>
Date:   Fri, 27 Jan 2023 03:48:05 +0900
From:   "Mrs Alice Walton" <daime@daime.co.jp>
To:     <INQUIRY@daime.co.jp>
Reply-To: <alicewaltton1@gmail.com>
Subject: INQUIRY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Priority: 3
ORGANIZATION: Mrs Alice Walton
X-MAILER: Active! mail
X-EsetResult: clean, %VIRUSNAME%
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1674758886;VERSION=7944;MC=2736029532;TRN=0;CRV=0;IPC=210.134.169.250;SP=4;SIPS=1;PI=5;F=0
X-I-ESET-AS: RN=0;RNP=
X-ESET-Antispam: OK
X-Spam-Status: Yes, score=7.8 required=5.0 tests=BAYES_50,
        FREEMAIL_FORGED_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOCALPART_IN_SUBJECT,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_NONE,SPF_PASS,T_HK_NAME_MR_MRS,UNRESOLVED_TEMPLATE,
        XPRIO_SHORT_SUBJ autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5003]
        *  1.3 RCVD_IN_VALIDITY_RPBL RBL: Relay in Validity RPBL,
        *      https://senderscore.org/blocklistlookup/
        *      [210.134.168.89 listed in bl.score.senderscore.com]
        * -0.0 RCVD_IN_MSPIKE_H2 RBL: Average reputation (+2)
        *      [210.134.168.89 listed in wl.mailspike.net]
        *  1.1 LOCALPART_IN_SUBJECT Local part of To: address appears in
        *      Subject
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [alicewaltton1[at]gmail.com]
        *  1.3 UNRESOLVED_TEMPLATE Headers contain an unresolved template
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 T_HK_NAME_MR_MRS No description available.
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
        *  1.0 XPRIO_SHORT_SUBJ Has X Priority header + short subject
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org


Greetings,

I trust you are well. I sent you an email yesterday, I just want to confirm if you received it.
Please let me know as soon as possible,

Regard
Mrs Alice Walton


