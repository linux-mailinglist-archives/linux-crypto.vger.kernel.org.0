Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96DF7622472
	for <lists+linux-crypto@lfdr.de>; Wed,  9 Nov 2022 08:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbiKIHJn (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 9 Nov 2022 02:09:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiKIHJl (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 9 Nov 2022 02:09:41 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBFD1132;
        Tue,  8 Nov 2022 23:09:40 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A96vEIr005002;
        Wed, 9 Nov 2022 07:09:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : content-type :
 content-transfer-encoding : mime-version : subject : message-id : date :
 cc : to; s=pp1; bh=7/YCDN6PN8WBgY1iBgXZUNO1l/RL87/zcLyAXXiAQ/M=;
 b=L5dnRC5yD86+VKBWtGXNaHovWwBVz4SnODiJgroc+qaDsOwwC9lBtGXgMXI14NYT+1yp
 M2EFzBxoZIFeVeYZFNDB3nZMxRZp5P2UeF9+OETfOz4dCqx81krQ9agxU7H2XUlr/yay
 YaeWgElPFXi17bYUI16wKPteRB1aPSunUZx9RuFNsA6Arf+seahXaTjrJEv4RvisbJwj
 0HoydUXa8ucN4n+I1iNCynsGr2ftPLQ/UYG4pNLyFbVQlWd3RMUjkX0qy84wDD5J3qQg
 KP6GQaRP+Y+kOp0/6wRaqSCJQb7jTOEskavrymxMPF7LoVG4TIAg7EALDJHcWiy8e19S Sw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kr7d1gc5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 07:09:35 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A9785oD012389;
        Wed, 9 Nov 2022 07:09:33 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3kngqgd8jb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 07:09:33 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A97A9Mc48693638
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Nov 2022 07:10:09 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1EEAD5204F;
        Wed,  9 Nov 2022 07:09:31 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.109.241.54])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 0C0B45204E;
        Wed,  9 Nov 2022 07:09:29 +0000 (GMT)
From:   Sachin Sant <sachinp@linux.ibm.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.200.110.1.12\))
Subject: [6.1.0-rc4-next-20221108] Boot failure on powerpc
Message-Id: <E051ACF6-5282-49D1-9C60-BB2450569268@linux.ibm.com>
Date:   Wed, 9 Nov 2022 12:39:18 +0530
Cc:     linux-crypto@vger.kernel.org, linux-next@vger.kernel.org
To:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
X-Mailer: Apple Mail (2.3731.200.110.1.12)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OAEt4bBx1Gl47r3EU_gsuBglFnSR6xu_
X-Proofpoint-ORIG-GUID: OAEt4bBx1Gl47r3EU_gsuBglFnSR6xu_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_01,2022-11-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 clxscore=1011 spamscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 mlxlogscore=586
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211090050
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

6.1.0-rc4-next-20221108 fails to boot on IBM Power Server with
following traces.

[    0.609442] PowerPC PowerNV PCI Hotplug Driver version: 0.1
[    0.609699] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.610037] tpm_ibmvtpm 30000003: CRQ initialization completed
[    1.681458] ------------[ cut here ]------------
[    1.681462] WARNING: CPU: 2 PID: 1 at kernel/kthread.c:75 =
kthread_should_stop+0x18/0x30
[    1.681472] Modules linked in:
[    1.681476] CPU: 2 PID: 1 Comm: swapper/0 Not tainted =
6.1.0-rc4-next-20221108 #4
[    1.681481] Hardware name: IBM,9080-HEX POWER10 (raw) 0x800200 =
0xf000006 of:IBM,FW1030.00 (NH1030_026) hv:phyp pSeries
[    1.681485] NIP:  c000000000191428 LR: c0000000009a62c4 CTR: =
0000000000000000
[    1.681489] REGS: c00000000396f280 TRAP: 0700   Not tainted  =
(6.1.0-rc4-next-20221108)
[    1.681493] MSR:  8000000002029033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: =
48000280  XER: 20040001
[    1.681501] CFAR: c0000000009a62c0 IRQMASK: 0  [    1.681501] GPR00: =
c0000000009a62c4 c00000000396f520 c0000000013eec00 0000000000000000  [   =
 1.681501] GPR04: 0000000000000000 0000000000000000 4b351b7ffb78f34e =
f80eacc0f221f708  [    1.681501] GPR08: bf665209645f03d4 =
0000000000000001 c00000000389b180 5a48c7887549a8c3  [    1.681501] =
GPR12: 0000000000000000 c00000000ffcdf00 c000000000012868 =
0000000000000000  [    1.681501] GPR16: 0000000000000000 =
0000000000000000 0000000000000000 0000000000000000  [    1.681501] =
GPR20: 0000000000000000 0000000000000000 c000000001039958 =
c000000003210aa0  [    1.681501] GPR24: c000000002d90bf8 =
c0000000029da418 c0000000029da250 c0000000029da2c8  [    1.681501] =
GPR28: 0000000000000000 0000000000000000 0000000000000020 =
0000000000000000  [    1.681541] NIP [c000000000191428] =
kthread_should_stop+0x18/0x30
[    1.681547] LR [c0000000009a62c4] =
add_hwgenerator_randomness+0x94/0x180
[    1.681553] Call Trace:
[    1.681555] [c00000000396f520] [c0000000009a62b8] =
add_hwgenerator_randomness+0x88/0x180 (unreliable)
[    1.681562] [c00000000396f570] [c0000000009a8590] =
add_early_randomness+0xd0/0x160
[    1.681568] [c00000000396f5b0] [c0000000009a8b58] =
hwrng_register+0x348/0x400
[    1.681574] [c00000000396f620] [c0000000009aa3a8] =
tpm_chip_register.part.0+0x118/0x2a0
[    1.681580] [c00000000396f6a0] [c0000000009ba040] =
tpm_ibmvtpm_probe+0x530/0x7d0
[    1.681586] [c00000000396f780] [c00000000010ff94] =
vio_bus_probe+0x94/0x150
[    1.681591] [c00000000396f7d0] [c0000000009d4424] =
really_probe+0x104/0x550
[    1.681596] [c00000000396f850] [c0000000009d4924] =
__driver_probe_device+0xb4/0x240
[    1.681600] [c00000000396f8d0] [c0000000009d4b04] =
driver_probe_device+0x54/0x130
[    1.681605] [c00000000396f910] [c0000000009d57b8] =
__driver_attach+0xe8/0x2f0
[    1.681610] [c00000000396f990] [c0000000009d0948] =
bus_for_each_dev+0xa8/0x130
[    1.681614] [c00000000396f9f0] [c0000000009d3894] =
driver_attach+0x34/0x50
[    1.681618] [c00000000396fa10] [c0000000009d2f28] =
bus_add_driver+0x218/0x300
[    1.681622] [c00000000396faa0] [c0000000009d6d34] =
driver_register+0xb4/0x1c0
[    1.681627] [c00000000396fb10] [c00000000010e960] =
__vio_register_driver+0x80/0xf0
[    1.681632] [c00000000396fb90] [c000000002067168] =
ibmvtpm_module_init+0x34/0x48
[    1.681638] [c00000000396fbb0] [c000000000012260] =
do_one_initcall+0x60/0x2f0
[    1.681644] [c00000000396fc90] [c000000002005430] =
do_initcalls+0x138/0x18c
[    1.681650] [c00000000396fd40] [c000000002005768] =
kernel_init_freeable+0x248/0x2bc
[    1.681655] [c00000000396fdb0] [c000000000012890] =
kernel_init+0x30/0x1b0
[    1.681659] [c00000000396fe10] [c00000000000cffc] =
ret_from_kernel_thread+0x5c/0x64
[    1.681664] Instruction dump:
[    1.681666] e92308b8 e8690000 7863f7e2 4e800020 60000000 60000000 =
7c0802a6 60000000  [    1.681673] e94d0908 812a0114 6d290020 79295fe2 =
<0b090000> e92a08b8 e8690000 7863ffe2  [    1.681679]=20
---[ end trace 0000000000000000 ]---
[    1.681684] BUG: Kernel NULL pointer dereference at 0x00000000
[    1.681688] Faulting instruction address: 0xc000000000191430
[    1.681692] Oops: Kernel access of bad area, sig: 11 [#1]
[    1.681694] LE PAGE_SIZE=3D64K MMU=3DHash SMP NR_CPUS=3D2048 NUMA =
pSeries
[    1.681698] Modules linked in:
[    1.681700] CPU: 2 PID: 1 Comm: swapper/0 Tainted: G        W         =
 6.1.0-rc4-next-20221108 #4
[    1.681705] Hardware name: IBM,9080-HEX POWER10 (raw) 0x800200 =
0xf000006 of:IBM,FW1030.00 (NH1030_026) hv:phyp pSeries
[    1.681709] NIP:  c000000000191430 LR: c0000000009a62c4 CTR: =
0000000000000000
[    1.681713] REGS: c00000000396f280 TRAP: 0380   Tainted: G        W   =
        (6.1.0-rc4-next-20221108)
[    1.681717] MSR:  8000000002009033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: =
48000280  XER: 20040001
[    1.681724] CFAR: c00000000000cba4 IRQMASK: 0  [    1.681724] GPR00: =
c0000000009a62c4 c00000000396f520 c0000000013eec00 0000000000000000  [   =
 1.681724] GPR04: 0000000000000000 0000000000000000 4b351b7ffb78f34e =
f80eacc0f221f708  [    1.681724] GPR08: bf665209645f03d4 =
0000000000000000 c00000000389b180 5a48c7887549a8c3  [    1.681724] =
GPR12: 0000000000000000 c00000000ffcdf00 c000000000012868 =
0000000000000000  [    1.681724] GPR16: 0000000000000000 =
0000000000000000 0000000000000000 0000000000000000  [    1.681724] =
GPR20: 0000000000000000 0000000000000000 c000000001039958 =
c000000003210aa0  [    1.681724] GPR24: c000000002d90bf8 =
c0000000029da418 c0000000029da250 c0000000029da2c8  [    1.681724] =
GPR28: 0000000000000000 0000000000000000 0000000000000020 =
0000000000000000  [    1.681762] NIP [c000000000191430] =
kthread_should_stop+0x20/0x30
[    1.681767] LR [c0000000009a62c4] =
add_hwgenerator_randomness+0x94/0x180
[    1.681772] Call Trace:
[    1.681774] [c00000000396f520] [c0000000009a62b8] =
add_hwgenerator_randomness+0x88/0x180 (unreliable)
[    1.681780] [c00000000396f570] [c0000000009a8590] =
add_early_randomness+0xd0/0x160
[    1.681786] [c00000000396f5b0] [c0000000009a8b58] =
hwrng_register+0x348/0x400
[    1.681791] [c00000000396f620] [c0000000009aa3a8] =
tpm_chip_register.part.0+0x118/0x2a0
[    1.681797] [c00000000396f6a0] [c0000000009ba040] =
tpm_ibmvtpm_probe+0x530/0x7d0
[    1.681802] [c00000000396f780] [c00000000010ff94] =
vio_bus_probe+0x94/0x150
[    1.681807] [c00000000396f7d0] [c0000000009d4424] =
really_probe+0x104/0x550
[    1.681811] [c00000000396f850] [c0000000009d4924] =
__driver_probe_device+0xb4/0x240
[    1.681816] [c00000000396f8d0] [c0000000009d4b04] =
driver_probe_device+0x54/0x130
[    1.681820] [c00000000396f910] [c0000000009d57b8] =
__driver_attach+0xe8/0x2f0
[    1.681825] [c00000000396f990] [c0000000009d0948] =
bus_for_each_dev+0xa8/0x130
[    1.681829] [c00000000396f9f0] [c0000000009d3894] =
driver_attach+0x34/0x50
[    1.681833] [c00000000396fa10] [c0000000009d2f28] =
bus_add_driver+0x218/0x300
[    1.681837] [c00000000396faa0] [c0000000009d6d34] =
driver_register+0xb4/0x1c0
[    1.681842] [c00000000396fb10] [c00000000010e960] =
__vio_register_driver+0x80/0xf0
[    1.681847] [c00000000396fb90] [c000000002067168] =
ibmvtpm_module_init+0x34/0x48
[    1.681853] [c00000000396fbb0] [c000000000012260] =
do_one_initcall+0x60/0x2f0
[    1.681857] [c00000000396fc90] [c000000002005430] =
do_initcalls+0x138/0x18c
[    1.681862] [c00000000396fd40] [c000000002005768] =
kernel_init_freeable+0x248/0x2bc
[    1.681868] [c00000000396fdb0] [c000000000012890] =
kernel_init+0x30/0x1b0
[    1.681872] [c00000000396fe10] [c00000000000cffc] =
ret_from_kernel_thread+0x5c/0x64
[    1.681876] Instruction dump:
[    1.681879] 7863f7e2 4e800020 60000000 60000000 7c0802a6 60000000 =
e94d0908 812a0114  [    1.681885] 6d290020 79295fe2 0b090000 e92a08b8 =
<e8690000> 7863ffe2 4e800020 60000000  [    1.681892] ---[ end trace =
0000000000000000 ]---
[    1.683353] pstore: backend (nvram) writing error (-1)
[    1.683356]  [    2.683359] Kernel panic - not syncing: Fatal =
exception
[    2.688014] Rebooting in 10 seconds..

Next-20221107 was good. Git bisect points to following patch

commit e0a37003ff0beed62e85a00e313b21764c5f1d4f
Date:   Sun Nov 6 16:02:43 2022 +0100
    hw_random: use add_hwgenerator_randomness() for early entropy

Reverting this patch allows the kernel to boot to login prompt.

- Sachin=
