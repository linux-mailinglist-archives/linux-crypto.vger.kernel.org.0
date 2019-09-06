Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21AEDAB03E
	for <lists+linux-crypto@lfdr.de>; Fri,  6 Sep 2019 03:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731742AbfIFBlE (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 5 Sep 2019 21:41:04 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55446 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732000AbfIFBlD (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 5 Sep 2019 21:41:03 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x861cqQU023870;
        Fri, 6 Sep 2019 01:40:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2019-08-05; bh=5bIIAuyfUX5ot9qkVRkA1hoq8E1NIAKWOOR9XDI0wCs=;
 b=CKEEMszxzmRLbpCbG5gZQlEQI387RSyBimIdPKWbChyZ2ytCiACPReyHrF6u5a4zwf8g
 p7V+GOtTCFm+ujV5vM66CE2oC1UXqtaGCXtBNzDS9/GHZM+eP7WZX/BH9RIjMJ7LXiKY
 JWJjdWSD7SxK2WsUqMb63zD2pbGhXZflx/+UXRJrRVjxz39/yUus2xG9zicvdo8XUige
 dDEh63luzSoghTSxbIRk6z687VxxTJv/nftIBL914dqfboBT+JKFUd99cEnQzHsxxKtA
 x3IO8SOl26KeKvYFkVssRc1YMFAXt0C77JaOMldD3JLolrd4yFkj8nCuz7PXheNvsASD 2Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2uudhy834y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Sep 2019 01:40:44 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x861cX0s188325;
        Fri, 6 Sep 2019 01:40:44 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2utpmc44w8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Sep 2019 01:40:44 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x861ec3s007086;
        Fri, 6 Sep 2019 01:40:38 GMT
Received: from localhost.localdomain (/98.229.125.203)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 05 Sep 2019 18:40:37 -0700
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: [PATCH v3 0/9] padata: use unbound workqueues for parallel jobs
Date:   Thu,  5 Sep 2019 21:40:20 -0400
Message-Id: <20190906014029.3345-1-daniel.m.jordan@oracle.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9371 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909060015
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9371 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909060016
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

v2 -> v3:
 - Rebase onto cryptodev.

v1 -> v2:
 - Updated patch 8 to avoid queueing the reorder work if the next object
   by sequence number isn't ready yet (Herbert)
 - Added Steffen's ack to all but patch 8 since that one changed.

RFC -> v1:
 - Included Tejun's acks.
 - Added testing section to cover letter.

Padata binds the parallel part of a job to a single CPU and round-robins
over all CPUs in the system for each successive job.  Though the serial
parts rely on per-CPU queues for correct ordering, they're not necessary
for parallel work, and it improves performance to run the job locally on
NUMA machines and let the scheduler pick the CPU within a node on a busy
system.
  
This series makes parallel padata jobs run on unbound workqueues.

Patch    Description
-----    -----------

    1    Make a padata instance allocate its workqueue internally.

    2    Unconfine some recently-confined workqueue interfaces.

  3-6    Address recursive CPU hotplug locking issue.

         padata_alloc* requires its callers to hold this lock, but allocating
         an unbound workqueue and calling apply_workqueue_attrs also take it.
         Fix by removing the requirement for callers of padata_alloc*.

  7-8    Add a second workqueue for each padata instance that's dedicated to
         parallel jobs.

    9    Small cleanup.

Performance
-----------

Measurements are from a 2-socket, 20-core, 40-CPU Xeon server.

For repeatability, modprobe was bound to a CPU and the serial cpumasks
for both pencrypt and pdecrypt were also restricted to a CPU different
from modprobe's.

  # modprobe tcrypt alg="pcrypt(rfc4106(gcm(aes)))" type=3
  # modprobe tcrypt mode=211 sec=1
  # modprobe tcrypt mode=215 sec=1

Busy system (tcrypt run while 10 stress-ng tasks were burning 100% CPU)

                             base                test
                             ----------------    ---------------
speedup    key_sz  blk_sz    ops/sec    stdev    ops/sec   stdev

(pcrypt(rfc4106-gcm-aesni)) encryption (tcrypt mode=211)

 117.2x       160      16        960       30     112555   24775
 135.1x       160      64        845      246     114145   25124
 113.2x       160     256        993       17     112395   24714
 111.3x       160     512       1000        0     111252   23755
 110.0x       160    1024        983       16     108153   22374
 104.2x       160    2048        985       22     102563   20530
  98.5x       160    4096        998        3      98346   18777
  86.2x       160    8192       1000        0      86173   14480

(pcrypt(rfc4106-gcm-aesni)) decryption (tcrypt mode=211)

 127.2x       160      16        997        5     126834   24244
 128.4x       160      64       1000        0     128438   23261
 127.6x       160     256        992        7     126627   23493
 124.0x       160     512       1000        0     123958   22746
 122.8x       160    1024        989       20     121372   22632
 112.8x       160    2048        998        3     112602   18287
 106.9x       160    4096        994       10     106255   16111
  91.7x       160    8192       1000        0      91742   11670

multibuffer (pcrypt(rfc4106-gcm-aesni)) encryption (tcrypt mode=215)

 242.2x       160      16       2363      141     572189   16846
 242.1x       160      64       2397      151     580424   11923
 231.1x       160     256       2472       21     571387   16364
 237.6x       160     512       2429       24     577264    8692
 238.3x       160    1024       2384       97     568155    6621
 216.3x       160    2048       2453       74     530627    3480
 209.2x       160    4096       2381      206     498192   19177
 176.5x       160    8192       2323      157     410013    9903

multibuffer (pcrypt(rfc4106-gcm-aesni)) decryption (tcrypt mode=215)

 220.3x       160      16       2341      228     515733   91317
 216.6x       160      64       2467       33     534381  101262
 217.7x       160     256       2451       45     533443   85418
 213.8x       160     512       2485       26     531293   83767
 211.0x       160    1024       2472       28     521677   80339
 200.8x       160    2048       2459       67     493808   63587
 188.8x       160    4096       2491        9     470325   58055
 159.9x       160    8192       2459       51     393147   25756

Idle system (tcrypt run by itself)

                             base                test
                             ----------------    ---------------
speedup    key_sz  blk_sz    ops/sec    stdev    ops/sec   stdev

(pcrypt(rfc4106-gcm-aesni)) encryption (tcrypt mode=211)

   2.5x       160      16      63412    43075     161615    1034
   4.1x       160      64      39554    24006     161653     981
   6.0x       160     256      26504     1436     160110    1158
   6.2x       160     512      25500       40     157018     951
   5.9x       160    1024      25777     1094     151852     915
   5.8x       160    2048      24653      218     143756     508
   5.6x       160    4096      24333       20     136752     548
   5.0x       160    8192      23310       15     117660     481

(pcrypt(rfc4106-gcm-aesni)) decryption (tcrypt mode=211)

   2.4x       160      16      53471    48279     128047   31328
   3.4x       160      64      37712    20855     128187   31074
   4.5x       160     256      27911     4378     126430   31084
   4.9x       160     512      25346      175     123870   29099
   3.1x       160    1024      38452    23118     120817   26846
   4.7x       160    2048      24612      187     115036   23942
   4.5x       160    4096      24217      114     109583   21559
   4.2x       160    8192      23144      108      96850   16686

multibuffer (pcrypt(rfc4106-gcm-aesni)) encryption (tcrypt mode=215)

   1.0x       160      16     412157     3855     426973    1591
   1.0x       160      64     412600     4410     431920    4224
   1.1x       160     256     410352     3254     453691   17831
   1.2x       160     512     406293     4948     473491   39818
   1.2x       160    1024     395123     7804     478539   27660
   1.2x       160    2048     385144     7601     453720   17579
   1.2x       160    4096     371989     3631     449923   15331
   1.2x       160    8192     346723     1617     399824   18559

multibuffer (pcrypt(rfc4106-gcm-aesni)) decryption (tcrypt mode=215)

   1.1x       160      16     407317     1487     452619   14404
   1.1x       160      64     411821     4261     464059   23541
   1.2x       160     256     408941     4945     477483   36576
   1.2x       160     512     406451      611     472661   11038
   1.2x       160    1024     394813     2667     456357   11452
   1.2x       160    2048     390291     4175     448928    8957
   1.2x       160    4096     371904     1068     449344   14225
   1.2x       160    8192     344227     1973     404397   19540

Testing
-------

In addition to the bare metal performance runs above, this series was
tested in a kvm guest with the tcrypt module (mode=215).  All
combinations of CPUs among parallel_cpumask, serial_cpumask, and CPU
hotplug online/offline were run with 3 possible CPUs, and over 2000
random combinations of these were run with 8 possible CPUs.  Workqueue
events were used throughout to verify that all parallel and serial
workers executed on only the CPUs allowed by the cpumask sysfs files.

Finally, tcrypt mode=215 was run at each patch in the series when built
with and without CONFIG_PADATA/CONFIG_CRYPTO_PCRYPT.

v2:  https://lore.kernel.org/linux-crypto/20190829173038.21040-1-daniel.m.jordan@oracle.com/
v1:  https://lore.kernel.org/linux-crypto/20190813005224.30779-1-daniel.m.jordan@oracle.com/
RFC: https://lore.kernel.org/lkml/20190725212505.15055-1-daniel.m.jordan@oracle.com/

Daniel Jordan (9):
  padata: allocate workqueue internally
  workqueue: unconfine alloc/apply/free_workqueue_attrs()
  workqueue: require CPU hotplug read exclusion for
    apply_workqueue_attrs
  padata: make padata_do_parallel find alternate callback CPU
  pcrypt: remove padata cpumask notifier
  padata, pcrypt: take CPU hotplug lock internally in
    padata_alloc_possible
  padata: use separate workqueues for parallel and serial work
  padata: unbind parallel jobs from specific CPUs
  padata: remove cpu_index from the parallel_queue

 Documentation/padata.txt  |  12 +--
 crypto/pcrypt.c           | 167 ++++---------------------------
 include/linux/padata.h    |  16 +--
 include/linux/workqueue.h |   4 +
 kernel/padata.c           | 201 ++++++++++++++++++++++----------------
 kernel/workqueue.c        |  25 +++--
 6 files changed, 170 insertions(+), 255 deletions(-)

-- 
2.23.0

