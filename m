Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2656A8F2
	for <lists+linux-crypto@lfdr.de>; Tue, 16 Jul 2019 14:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbfGPMxV (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 16 Jul 2019 08:53:21 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38392 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727849AbfGPMxU (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 16 Jul 2019 08:53:20 -0400
Received: by mail-wr1-f65.google.com with SMTP id g17so20840027wrr.5
        for <linux-crypto@vger.kernel.org>; Tue, 16 Jul 2019 05:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yazVOO3iTYBRMQULwRwZVDyE2scRH2IKVdUe1u2gmOw=;
        b=DKQ581htLJQ56ZOJaT5FgLh1LXLSBNdlTYqeheUkeMjc0nH2OLkvxz4tdiHDCDKgze
         eJKayH+uFhNeXMgVb23QKEuiY5sMvAeR6EP/gBhPTwP1yeBarxHlTDQC+j9Qaha/BS1L
         Fss3rIyzd3CNurC1oxSZTu/+PKtXVSEJtuAWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yazVOO3iTYBRMQULwRwZVDyE2scRH2IKVdUe1u2gmOw=;
        b=enxfqIrOUVKKo0qfZU3kFzAf4y9OvvluysdJNwl9HzwhZQAqeVfGjRnXNZI1yG1puX
         eEOIrEFgxA5QXEiTcm+4miZRDeJZegdGMighH8s1USN4NCVPVIYzjKTebSj4nzUdgj+m
         X7upCAiq1f2x5dB33m/cp3jWp/2jMrLtVviNYwoRqJnXWpdLn5MGfgfhgSx+APHAFlSu
         m7WyB0T5QzZ3hs4BtG51ZIVrugAlXFZmf7NsFKWhYMPBgnbQPfTIy5SAt77ZwvwMfF8c
         cQveVDAAOmMHiMAUJfLFhIuCCatyH/2RdYq8acAPFWlDkJhWpgVwPgWDICA2W/3b7No0
         I4uw==
X-Gm-Message-State: APjAAAXpiPiXZ37mr5vTEJXBQKh3fHjkruaUCdiHaRP1JkI/hHf8mog6
        o+IQmU/lt4pTC577x+hW4Ok8wA==
X-Google-Smtp-Source: APXvYqzu1vTspyk2jf/HErrlXlwzxNRRcNX5JAEUAK+QB6I8ayhtDWL/42dn6RVIMQJgt1t4XxOXtA==
X-Received: by 2002:adf:db0b:: with SMTP id s11mr35975157wri.7.1563281598676;
        Tue, 16 Jul 2019 05:53:18 -0700 (PDT)
Received: from andrea (host234-214-static.12-87-b.business.telecomitalia.it. [87.12.214.234])
        by smtp.gmail.com with ESMTPSA id n5sm16809733wmi.21.2019.07.16.05.53.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 05:53:17 -0700 (PDT)
Date:   Tue, 16 Jul 2019 14:53:09 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>, boqun.feng@gmail.com,
        paulmck@linux.ibm.com, peterz@infradead.org,
        linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] padata: use smp_mb in padata_reorder to avoid orphaned
 padata jobs
Message-ID: <20190716125309.GA10672@andrea>
References: <20190711221205.29889-1-daniel.m.jordan@oracle.com>
 <20190712100636.mqdr567p7ozanlyl@gondor.apana.org.au>
 <20190712101012.GW14601@gauss3.secunet.de>
 <20190712160737.iniaaxlsnhs6azg5@ca-dmjordan1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712160737.iniaaxlsnhs6azg5@ca-dmjordan1.us.oracle.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hi Daniel,

My two cents (summarizing some findings we discussed privately):


> I think adding the full barrier guarantees the following ordering, and the
> memory model people can correct me if I'm wrong:
> 
> CPU21                      CPU22
> ------------------------   --------------------------
> UNLOCK pd->lock
> smp_mb()
> LOAD reorder_objects
>                            INC reorder_objects
>                            spin_unlock(&pqueue->reorder.lock) // release barrier
>                            TRYLOCK pd->lock
> 
> So if CPU22 has incremented reorder_objects but CPU21 reads 0 for it, CPU21
> should also have unlocked pd->lock so CPU22 can get it and serialize any
> remaining jobs.

This information inspired me to write down the following litmus test:
(AFAICT, you independently wrote a very similar test, which is indeed
quite reassuring! ;D)

C daniel-padata

{ }

P0(atomic_t *reorder_objects, spinlock_t *pd_lock)
{
	int r0;

	spin_lock(pd_lock);
	spin_unlock(pd_lock);
	smp_mb();
	r0 = atomic_read(reorder_objects);
}

P1(atomic_t *reorder_objects, spinlock_t *pd_lock, spinlock_t *reorder_lock)
{
	int r1;

	spin_lock(reorder_lock);
	atomic_inc(reorder_objects);
	spin_unlock(reorder_lock);
	//smp_mb();
	r1 = spin_trylock(pd_lock);
}

exists (0:r0=0 /\ 1:r1=0)

It seems worth noticing that this test's "exists" clause is satisfiable
according to the (current) memory consistency model.  (Informally, this
can be explained by noticing that the RELEASE from the spin_unlock() in
P1 does not provide any order between the atomic increment and the read
part of the spin_trylock() operation.)  FWIW, uncommenting the smp_mb()
in P1 would suffice to prevent this clause from being satisfiable; I am
not sure, however, whether this approach is feasible or ideal... (sorry,
I'm definitely not too familiar with this code... ;/)

Thanks,
  Andrea
