Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 003C63A966F
	for <lists+linux-crypto@lfdr.de>; Wed, 16 Jun 2021 11:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbhFPJmu (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 16 Jun 2021 05:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbhFPJmt (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 16 Jun 2021 05:42:49 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC95C061574
        for <linux-crypto@vger.kernel.org>; Wed, 16 Jun 2021 02:40:43 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id p13so1801518pfw.0
        for <linux-crypto@vger.kernel.org>; Wed, 16 Jun 2021 02:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=qIQsPLfRL4d2MvzdGI8jgQgnruwnGEFk1JWG+6+7r2s=;
        b=euUc74ar/0TxArEGc/5H62X4xt28rpx7WOxCNGPEzWfw8iNIBdt3q8q+TbxC51Nsx0
         Jsv7jtILpIEAatut8kUzm3cBM1CtwAZ7NZc1YpVXKzcY0hmeARAXZyVwZ2CxKRHIo0/B
         WVsVgOv0Kjg82CqH0Yftq8lYvZgBZwkhFf2fUPeo4ZCPnfQNm5iWkvJIUI5IlQJ40nnZ
         staO5L8VK+C4MC/pNwywvTlZ0VzJknce2h5DI8A5iw+toVC4uHz8eGbGYjTIk07kegVP
         OhXW23QX5TbJ/SnXGv32j3kuycUWcl+e9xaQZdQsHYWCyXO7fVgT3v/rZ3eTYKHk7HQJ
         InHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=qIQsPLfRL4d2MvzdGI8jgQgnruwnGEFk1JWG+6+7r2s=;
        b=mUdqTGzm1Jh589Lv/0guTSZ+6CDR2vREHtE6e88atLJSgEFweD5VbT2couEmtrsRyu
         Uw8fySNPZLlpLxKhUk9YIFa/6b5EEXnLopoZssYU9Jv/F2rMkjh/JjFOISO3wYlxzlFM
         vhWsesMy2rWxevv0HjF63pcQRH1rLx5EG/TCu6cSWOqa1RA8RJm1X712eTSoeKTTuCdD
         6WY97SMZK2QOuHfx9zkDulm40Vh+OKCxNpDQ9VQVdQKNDt5RC8n3jJ6dC/LPAjncFx/M
         vOcUAw6G4viFxibtx1UZ5wLFggQGXWpq5es1C9IwjoZRz/vuFYieiMNzIl2n1c7ttQ6J
         Oo/g==
X-Gm-Message-State: AOAM5319u8vauJFqnqgnAf+3M1bs5stazuJkbEcYK3gVNq3XAm06PYby
        G2FB5qhc9MuL9HarB7aiIw0=
X-Google-Smtp-Source: ABdhPJxj93kB6eqx38UPRcaHxkmCbWIvNWtzYc2gP6WxOULe2mGa5LfNyn7WIMYQ6XL/877yKkTQUg==
X-Received: by 2002:a62:b50b:0:b029:2fc:db53:a56a with SMTP id y11-20020a62b50b0000b02902fcdb53a56amr3681313pfe.30.1623836443319;
        Wed, 16 Jun 2021 02:40:43 -0700 (PDT)
Received: from localhost (60-242-147-73.tpgi.com.au. [60.242.147.73])
        by smtp.gmail.com with ESMTPSA id u24sm1802588pfm.200.2021.06.16.02.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 02:40:43 -0700 (PDT)
Date:   Wed, 16 Jun 2021 19:40:38 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v5 13/17] powerpc/pseries/vas: Setup IRQ and fault
 handling
To:     Haren Myneni <haren@linux.ibm.com>, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mpe@ellerman.id.au
Cc:     haren@us.ibm.com, hbabu@us.ibm.com
References: <ed7a09822cf3a2e463f942e5a37309a2365c9d79.camel@linux.ibm.com>
        <8a9fe47a17d1f89cc43885d2ef8c2f09e4e90d7a.camel@linux.ibm.com>
        <1623639403.054wgu233i.astroid@bobo.none>
        <09992f14d25b9212686acfa85e8e4cab93b6b1fc.camel@linux.ibm.com>
In-Reply-To: <09992f14d25b9212686acfa85e8e4cab93b6b1fc.camel@linux.ibm.com>
MIME-Version: 1.0
Message-Id: <1623836349.w9whhftphe.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Excerpts from Haren Myneni's message of June 15, 2021 7:01 pm:
> On Mon, 2021-06-14 at 13:07 +1000, Nicholas Piggin wrote:
>> Excerpts from Haren Myneni's message of June 13, 2021 9:02 pm:
>> > NX generates an interrupt when sees a fault on the user space
>> > buffer and the hypervisor forwards that interrupt to OS. Then
>> > the kernel handles the interrupt by issuing H_GET_NX_FAULT hcall
>> > to retrieve the fault CRB information.
>> >=20
>> > This patch also adds changes to setup and free IRQ per each
>> > window and also handles the fault by updating the CSB.
>> >=20
>> > Signed-off-by: Haren Myneni <haren@linux.ibm.com>
>> > ---
>> >  arch/powerpc/platforms/pseries/vas.c | 108
>> > +++++++++++++++++++++++++++
>> >  1 file changed, 108 insertions(+)
>> >=20
>> > diff --git a/arch/powerpc/platforms/pseries/vas.c
>> > b/arch/powerpc/platforms/pseries/vas.c
>> > index fe375f7a7029..55185bdd3776 100644
>> > --- a/arch/powerpc/platforms/pseries/vas.c
>> > +++ b/arch/powerpc/platforms/pseries/vas.c
>> > @@ -11,6 +11,7 @@
>> >  #include <linux/types.h>
>> >  #include <linux/delay.h>
>> >  #include <linux/slab.h>
>> > +#include <linux/interrupt.h>
>> >  #include <asm/machdep.h>
>> >  #include <asm/hvcall.h>
>> >  #include <asm/plpar_wrappers.h>
>> > @@ -190,6 +191,58 @@ int h_query_vas_capabilities(const u64 hcall,
>> > u8 query_type, u64 result)
>> >  }
>> >  EXPORT_SYMBOL_GPL(h_query_vas_capabilities);
>> > =20
>> > +/*
>> > + * hcall to get fault CRB from pHyp.
>> > + */
>> > +static int h_get_nx_fault(u32 winid, u64 buffer)
>> > +{
>> > +	long rc;
>> > +
>> > +	rc =3D plpar_hcall_norets(H_GET_NX_FAULT, winid, buffer);
>> > +
>> > +	switch (rc) {
>> > +	case H_SUCCESS:
>> > +		return 0;
>> > +	case H_PARAMETER:
>> > +		pr_err("HCALL(%x): Invalid window ID %u\n",
>> > H_GET_NX_FAULT,
>> > +		       winid);
>> > +		return -EINVAL;
>> > +	case H_PRIVILEGE:
>> > +		pr_err("HCALL(%x): Window(%u): Invalid fault buffer
>> > 0x%llx\n",
>> > +		       H_GET_NX_FAULT, winid, buffer);
>> > +		return -EACCES;
>> > +	default:
>> > +		pr_err("HCALL(%x): Failed with error %ld for
>> > window(%u)\n",
>> > +		       H_GET_NX_FAULT, rc, winid);
>> > +		return -EIO;
>>=20
>> 3 error messages have 3 different formats for window ID.
>>=20
>> I agree with Michael you could just have one error message that
>> reports=20
>> the return value. Also "H_GET_NX_FAULT: " would be nicer than
>> "HCALL(380): "
>=20
> yes, Added just one printk for all error codes except for errors which
> depend on arguments to HCALL (Ex: WinID).
>=20
> Sure, I will add just one error message and print all arguments passed
> to HCALL.=20
>=20
> pr_err("H_GET_NX_FAULT: window(%u), fault buffer(0x%llx) Failed with
> error %ld\n", rc, winid, buffer);

Thanks.

>>=20
>> Check how some other hcall failures are reported, "hcall failed:=20
>> H_CALL_NAME" seems to have a few takers.
>>=20
>> > +	}
>> > +}
>> > +
>> > +/*
>> > + * Handle the fault interrupt.
>> > + * When the fault interrupt is received for each window, query
>> > pHyp to get
>> > + * the fault CRB on the specific fault. Then process the CRB by
>> > updating
>> > + * CSB or send signal if the user space CSB is invalid.
>> > + * Note: pHyp forwards an interrupt for each fault request. So one
>> > fault
>> > + *	CRB to process for each H_GET_NX_FAULT HCALL.
>> > + */
>> > +irqreturn_t pseries_vas_fault_thread_fn(int irq, void *data)
>> > +{
>> > +	struct pseries_vas_window *txwin =3D data;
>> > +	struct coprocessor_request_block crb;
>> > +	struct vas_user_win_ref *tsk_ref;
>> > +	int rc;
>> > +
>> > +	rc =3D h_get_nx_fault(txwin->vas_win.winid,
>> > (u64)virt_to_phys(&crb));
>> > +	if (!rc) {
>> > +		tsk_ref =3D &txwin->vas_win.task_ref;
>> > +		vas_dump_crb(&crb);
>> > +		vas_update_csb(&crb, tsk_ref);
>> > +	}
>> > +
>> > +	return IRQ_HANDLED;
>> > +}
>> > +
>> >  /*
>> >   * Allocate window and setup IRQ mapping.
>> >   */
>> > @@ -201,10 +254,51 @@ static int allocate_setup_window(struct
>> > pseries_vas_window *txwin,
>> >  	rc =3D h_allocate_vas_window(txwin, domain, wintype,
>> > DEF_WIN_CREDS);
>> >  	if (rc)
>> >  		return rc;
>> > +	/*
>> > +	 * On powerVM, pHyp setup and forwards the fault interrupt per
>>=20
>>            The hypervisor forwards the fault interrupt per-window...
>>=20
>> > +	 * window. So the IRQ setup and fault handling will be done for
>> > +	 * each open window separately.
>> > +	 */
>> > +	txwin->fault_virq =3D irq_create_mapping(NULL, txwin->fault_irq);
>> > +	if (!txwin->fault_virq) {
>> > +		pr_err("Failed irq mapping %d\n", txwin->fault_irq);
>> > +		rc =3D -EINVAL;
>> > +		goto out_win;
>> > +	}
>> > +
>> > +	txwin->name =3D kasprintf(GFP_KERNEL, "vas-win-%d",
>> > +				txwin->vas_win.winid);
>> > +	if (!txwin->name) {
>> > +		rc =3D -ENOMEM;
>> > +		goto out_irq;
>> > +	}
>> > +
>> > +	rc =3D request_threaded_irq(txwin->fault_virq, NULL,
>> > +				  pseries_vas_fault_thread_fn,
>> > IRQF_ONESHOT,
>> > +				  txwin->name, txwin);
>> > +	if (rc) {
>> > +		pr_err("VAS-Window[%d]: Request IRQ(%u) failed with
>> > %d\n",
>> > +		       txwin->vas_win.winid, txwin->fault_virq, rc);
>> > +		goto out_free;
>> > +	}
>> > =20
>> >  	txwin->vas_win.wcreds_max =3D DEF_WIN_CREDS;
>> > =20
>> >  	return 0;
>> > +out_free:
>> > +	kfree(txwin->name);
>> > +out_irq:
>> > +	irq_dispose_mapping(txwin->fault_virq);
>> > +out_win:
>> > +	h_deallocate_vas_window(txwin->vas_win.winid);
>> > +	return rc;
>> > +}
>> > +
>> > +static inline void free_irq_setup(struct pseries_vas_window
>> > *txwin)
>> > +{
>> > +	free_irq(txwin->fault_virq, txwin);
>> > +	irq_dispose_mapping(txwin->fault_virq);
>> > +	kfree(txwin->name);
>>=20
>> Nit, but this freeing is in a different order than the error handling
>> in=20
>> the function does. I'd just keep it the same unless there is a reason
>> to=20
>> be different, in which case it could use a comment.
>=20
> shouldn't matter, I can change it to:
> static inline void free_irq_setup(struct pseries_vas_window *txwin)
> {
>         free_irq(txwin->fault_virq, txwin);
>         kfree(txwin->name);
>         irq_dispose_mapping(txwin->fault_virq);
> }

Okay, it wasn't a big deal I was just wondering. Given the changes,

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Thanks,
Nick
