Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A7E682FE3
	for <lists+linux-crypto@lfdr.de>; Tue, 31 Jan 2023 15:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjAaO5O (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 31 Jan 2023 09:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbjAaO5N (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 31 Jan 2023 09:57:13 -0500
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C69D51C7C;
        Tue, 31 Jan 2023 06:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.es; i=@amazon.es; q=dns/txt; s=amazon201209;
  t=1675177015; x=1706713015;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XSDcZI74s9f8AMx7xjEoypdbAe3QClb1iLeEjBiKsBI=;
  b=EvUMvy9LUUaeUkv8clzUbJP6p1GkVRTTMrBB/Za8FF5tA7eB3Wa+8aZk
   OX324yvcIgADEt0PX+Zs6At7JC2VWK71y4agYG/1/XgriocclMmkjfz2S
   W6q26TeX9JQ/NqNhqgqLZRdKDRsrAqhe+0DfvIrTsINpcO80adHu0wKg8
   w=;
X-IronPort-AV: E=Sophos;i="5.97,261,1669075200"; 
   d="scan'208";a="292084543"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-d40ec5a9.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 14:56:52 +0000
Received: from EX13D43EUB003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2a-m6i4x-d40ec5a9.us-west-2.amazon.com (Postfix) with ESMTPS id C756241DC7;
        Tue, 31 Jan 2023 14:56:48 +0000 (UTC)
Received: from EX19D037EUB003.ant.amazon.com (10.252.61.119) by
 EX13D43EUB003.ant.amazon.com (10.43.166.195) with Microsoft SMTP Server (TLS)
 id 15.0.1497.45; Tue, 31 Jan 2023 14:56:47 +0000
Received: from f4d4887fdcfb.ant.amazon.com (10.43.161.198) by
 EX19D037EUB003.ant.amazon.com (10.252.61.119) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.24; Tue, 31 Jan 2023 14:56:41 +0000
From:   Babis Chalios <bchalios@amazon.es>
To:     Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Jason Wang" <jasowang@redhat.com>,
        Babis Chalios <bchalios@amazon.es>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
CC:     <sgarzare@redhat.com>, <amit@kernel.org>, <graf@amazon.de>,
        <Jason@zx2c4.com>, <xmarcalx@amazon.co.uk>
Subject: [PATCH v2 0/2] [RFC] virtio-rng entropy leak reporting feature
Date:   Tue, 31 Jan 2023 15:55:41 +0100
Message-ID: <20230131145543.86369-1-bchalios@amazon.es>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
X-Originating-IP: [10.43.161.198]
X-ClientProxiedBy: EX13D39UWB001.ant.amazon.com (10.43.161.5) To
 EX19D037EUB003.ant.amazon.com (10.252.61.119)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org


Recently, a proposal has been published [1] for a new feature in the
VirtIO RNG device which will allows the device to report "entropy leaks"
to the guest VM. Such an event occurs when, for example, we take a VM
snapshot, or when we restore a VM from a snapshot.

The feature allows the guest to request for certain operations to be
performed upon an entropy leak event. When such an event occurs, the
device will handle the requests and add the request buffers to the used
queue. Adding these buffers to the used queue operates as a notification
towards the guest about the entropy leak event.

The proposed changes describe two types of requests that can be
performed: (1) fill a buffer in guest memory with random bytes and (2)
perform a memory copy between two buffers in guest memory.

The mechanism provides similar functionality to Microsoft's Virtual
Machine Generation ID and it can be used to re-seed the kernel's PRNG
upon taking a VM snapshot or resuming from one. Additionally, it allows
to (1) avoid the race-condition that exists with our VMGENID
implementation, between the time a VM is resumed after a "leak event"
and the handling of the ACPI notification before adding the new entropy.
Finally, it allows building on top of it to provide a mechanism for
notifying user-space about such events.

The first patch of this series, extends the current virtio-rng driver to
implement the new feature and ensures that there is always a request to
get some random bytes from the device in the event of an entropy leak
and uses these bytes as entropy through the `add_device_randomness`.

The second patch adds a copy-on-leak command as well in the queue,
implementating the idea of a generation counter that has previously been
part of the VMGENID saga. It then exposes the value of the generation
counter over a sysfs file. User-space can read, mmap and poll on the
file in order to be notified about entropy leak events.

I have performed basic tests of the user-space interfaces using a
Firecracker where I implemented virtio-rng with the proposed features.
Instructions on how to replicate this can be found here:
https://github.com/bchalios/virtio-snapsafe-example

The patchset does not solve all problems. We do not define an API for
other parts of the kernel to be able to use directly the new
functionality (add commands to the queue), mainly because I 'm not sure
what would the correct API be. I was toying with the idea of extending
`struct hwrng` with two new hooks that would be implemented only by
virtio-rng but I'm not sure I like it, so I am open to suggestions.

As a result of the above, the way we use the functionality to add new
entropy, i.e. calling `add_device_randomness`, is as racy as the VMGENID
case, since it relies on used buffers been handled by the virtio driver.

As for user-space, the `mmap` interface *is* race-free. Changes in the
generation counter will be observable by user applications the moment VM
vcpus resume. However, the `poll` interface isn't, `sysfs_notify` is
being called as well when the virtio driver handles used buffers. I am
not sure I have a solution for this last one.

Posting this, I hope we can resume the discussion about solving the
above issues (or any other issue that I haven't thought of), especially
with regards to providing a mechanism suitable for user-space
notifications.

Cheers,
Babis

Changes in v2: fix kbuild warnings

Babis Chalios (2):
  virtio-rng: implement entropy leak feature
  virtio-rng: add sysfs entries for leak detection

 drivers/char/hw_random/virtio-rng.c | 372 +++++++++++++++++++++++++++-
 include/uapi/linux/virtio_rng.h     |   3 +
 2 files changed, 368 insertions(+), 7 deletions(-)

-- 
2.38.1

Amazon Spain Services sociedad limitada unipersonal, Calle Ramirez de Prado 5, 28045 Madrid. Registro Mercantil de Madrid . Tomo 22458 . Folio 102 . Hoja M-401234 . CIF B84570936

