Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961755FE1EC
	for <lists+linux-crypto@lfdr.de>; Thu, 13 Oct 2022 20:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbiJMSrM (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 13 Oct 2022 14:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiJMSqa (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 13 Oct 2022 14:46:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D132B1AB
        for <linux-crypto@vger.kernel.org>; Thu, 13 Oct 2022 11:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665686474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vsO4hYJKt+wtVYN9Zqac/Tunho9CLrg8yUdRp7WUlZA=;
        b=ZaD1OHhWsL7+F2rTovx5tAQySxdaQ92CaramnEluPW19rt8JnKs1TpwpufDefvMzV8cq5r
        qaBelSQEtek2+wfSAbr2vQ3HbKES1I0okXHtA2Uu2uXF8cuohacbwK1JOfEn+f8TD9HOCO
        41e5/SKWthkTRiE6QTpi/BxZiaa5Azs=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-312-n9nz8LkvPLa5S5A8vM8aDQ-1; Thu, 13 Oct 2022 14:41:09 -0400
X-MC-Unique: n9nz8LkvPLa5S5A8vM8aDQ-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-13259536f3bso1502829fac.10
        for <linux-crypto@vger.kernel.org>; Thu, 13 Oct 2022 11:41:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vsO4hYJKt+wtVYN9Zqac/Tunho9CLrg8yUdRp7WUlZA=;
        b=sbwtj29mNw9w/vmCfxJi0wYqRCFti0qxbSVJGit0yigR2JmKKEPpTVLApTOCPab+QU
         woOXXrNEYYO1X2ZSelw6Sk4RNqMd8CiQwBj6k/0zUDr/8JFkJqXZM555TYrxk/Zq6hVA
         EULHzSeNHqKZEe/6lMZ5bZFiV7lbHDxJShF0N8QyksMehI3LV263nf6SZetpjte0cBdz
         R2SFZwOuS88gHg134nIwLN+UV1+vh8blpCw2vGXbeXCk/Q2FAqs+mgdgu0VRNTMskzsh
         APgcsm5Oco9JoizpiDwYPIfZovw39HSuLCKyo5XmtkTOBRXWcx0DGlkjb7E8DEB5ZIob
         80tg==
X-Gm-Message-State: ACrzQf0jcyt2TsqFPAclrrOhijuiMcZRwEe93kNWK9j1583l5X2uaHpM
        uwq81slSCy1G6dDZsrODGMmKwQTi9hPaI8boWyquUT1xVwmxv9TsovwOSDHZdnpYARLeE1A7ueO
        oVF9SW2kqbodam22L7Ih+v7an
X-Received: by 2002:a05:6808:10c3:b0:350:e563:7c4a with SMTP id s3-20020a05680810c300b00350e5637c4amr598503ois.182.1665686468382;
        Thu, 13 Oct 2022 11:41:08 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7GzHFdCUGCQhqNsosJjZKt8Eeu2wVwQ9Do3KHBGqH13o0NNm/9FKqwNNjhBy1g53fEGrBUSA==
X-Received: by 2002:a05:6808:10c3:b0:350:e563:7c4a with SMTP id s3-20020a05680810c300b00350e5637c4amr598464ois.182.1665686468134;
        Thu, 13 Oct 2022 11:41:08 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a801:9473:d360:c737:7c9c:d52b])
        by smtp.gmail.com with ESMTPSA id v13-20020a05683024ad00b006618ad77a63sm244521ots.74.2022.10.13.11.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 11:41:07 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Leonardo Bras <leobras@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Phil Auld <pauld@redhat.com>,
        Antoine Tenart <atenart@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Wang Yufen <wangyufen@huawei.com>, mtosatti@redhat.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v2 3/4] sched/isolation: Add HK_TYPE_WQ to isolcpus=domain
Date:   Thu, 13 Oct 2022 15:40:28 -0300
Message-Id: <20221013184028.129486-4-leobras@redhat.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221013184028.129486-1-leobras@redhat.com>
References: <20221013184028.129486-1-leobras@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Housekeeping code keeps multiple cpumasks in order to keep track of which
cpus can perform given housekeeping category.

Every time the HK_TYPE_WQ cpumask is checked before queueing work at a cpu
WQ it also happens to check for HK_TYPE_DOMAIN. So It can be assumed that
the Domain isolation also ends up isolating work queues.

Delegating current HK_TYPE_DOMAIN's work queue isolation to HK_TYPE_WQ
makes it simpler to check if a cpu can run a task into an work queue, since
code just need to go through a single HK_TYPE_* cpumask.

Make isolcpus=domain aggregate both HK_TYPE_DOMAIN and HK_TYPE_WQ, and
remove a lot of cpumask_and calls.

Also, remove a unnecessary '|=' at housekeeping_isolcpus_setup() since we
are sure that 'flags == 0' here.

Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
 drivers/pci/pci-driver.c | 13 +------------
 kernel/sched/isolation.c |  4 ++--
 kernel/workqueue.c       |  1 -
 net/core/net-sysfs.c     |  1 -
 4 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 107d77f3c8467..550bef2504b8d 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -371,19 +371,8 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
 	    pci_physfn_is_probed(dev)) {
 		cpu = nr_cpu_ids;
 	} else {
-		cpumask_var_t wq_domain_mask;
-
-		if (!zalloc_cpumask_var(&wq_domain_mask, GFP_KERNEL)) {
-			error = -ENOMEM;
-			goto out;
-		}
-		cpumask_and(wq_domain_mask,
-			    housekeeping_cpumask(HK_TYPE_WQ),
-			    housekeeping_cpumask(HK_TYPE_DOMAIN));
-
 		cpu = cpumask_any_and(cpumask_of_node(node),
-				      wq_domain_mask);
-		free_cpumask_var(wq_domain_mask);
+				      housekeeping_cpumask(HK_TYPE_WQ));
 	}
 
 	if (cpu < nr_cpu_ids)
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 373d42c707bc5..ced4b78564810 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -204,7 +204,7 @@ static int __init housekeeping_isolcpus_setup(char *str)
 
 		if (!strncmp(str, "domain,", 7)) {
 			str += 7;
-			flags |= HK_FLAG_DOMAIN;
+			flags |= HK_FLAG_DOMAIN | HK_FLAG_WQ;
 			continue;
 		}
 
@@ -234,7 +234,7 @@ static int __init housekeeping_isolcpus_setup(char *str)
 
 	/* Default behaviour for isolcpus without flags */
 	if (!flags)
-		flags |= HK_FLAG_DOMAIN;
+		flags = HK_FLAG_DOMAIN | HK_FLAG_WQ;
 
 	return housekeeping_setup(str, flags);
 }
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 7cd5f5e7e0a1b..b557daa571f17 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -6004,7 +6004,6 @@ void __init workqueue_init_early(void)
 
 	BUG_ON(!alloc_cpumask_var(&wq_unbound_cpumask, GFP_KERNEL));
 	cpumask_copy(wq_unbound_cpumask, housekeeping_cpumask(HK_TYPE_WQ));
-	cpumask_and(wq_unbound_cpumask, wq_unbound_cpumask, housekeeping_cpumask(HK_TYPE_DOMAIN));
 
 	pwq_cache = KMEM_CACHE(pool_workqueue, SLAB_PANIC);
 
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 8409d41405dfe..7b6fb62a118ab 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -852,7 +852,6 @@ static ssize_t store_rps_map(struct netdev_rx_queue *queue,
 	}
 
 	if (!cpumask_empty(mask)) {
-		cpumask_and(mask, mask, housekeeping_cpumask(HK_TYPE_DOMAIN));
 		cpumask_and(mask, mask, housekeeping_cpumask(HK_TYPE_WQ));
 		if (cpumask_empty(mask)) {
 			free_cpumask_var(mask);
-- 
2.38.0

