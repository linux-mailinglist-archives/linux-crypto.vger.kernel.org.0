Return-Path: <linux-crypto+bounces-24365-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCGkNYfdDWqC4QUAu9opvQ
	(envelope-from <linux-crypto+bounces-24365-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Wed, 20 May 2026 18:12:55 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8171E5919F6
	for <lists+linux-crypto@lfdr.de>; Wed, 20 May 2026 18:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 34F9A300A324
	for <lists+linux-crypto@lfdr.de>; Wed, 20 May 2026 16:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95C8346E7B;
	Wed, 20 May 2026 16:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="URkhHbBY"
X-Original-To: linux-crypto@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724A633FE00
	for <linux-crypto@vger.kernel.org>; Wed, 20 May 2026 16:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779293339; cv=none; b=dEa7eguSKL9sxljbhKKWsRjEkXOG85tgml642g6gapSXi1GVn0ULQYbVvn5gUwn/2fAZFJfkc+litMkSE3sbnkITQlygqMRKoMQKJN1slqaQnA4eghu63tMOnGIFRIO1dVZvqNDYpcuNJbg5JXvDc8UkOq44V7QCoYGViSfCBKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779293339; c=relaxed/simple;
	bh=k59UMb8RUithwds8AxyeMKLGXUwQKUZoGOu6V0GVbEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CWQEoWUDSIENmZTNP1kykXDiBeLqNhPMEMp9oU960EWzNO26S10Y6ooOOv6GZf8x23ON1aCNxQtYi2uvj3yWTBSyv0pfvzbofP9nV8OzoNMw0pIIBnWPJVH0ZL3EMwnrDyB3W+ZVPS9UYM46rvPVuUDqEmsSUXHCutsZsUAneeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=URkhHbBY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779293337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k59UMb8RUithwds8AxyeMKLGXUwQKUZoGOu6V0GVbEA=;
	b=URkhHbBYYDXBEk14apW7cRFbXmeRqbbFc1GOsOwOeKOw5mZSs8zdup+XkEkhtNq0WZbiUy
	rO7BpS9zf0xP0Eq7tChszBH2l6lji1lqzn73y/EnqDFWnMI+QTTE13n4UfWD9ZBiHsP7HV
	GzQ4qiVyaV1ZuqXeK2/0OFgRXWj2zLo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-526-geOa9zixMr2oS9yNhZ80xA-1; Wed,
 20 May 2026 12:08:53 -0400
X-MC-Unique: geOa9zixMr2oS9yNhZ80xA-1
X-Mimecast-MFC-AGG-ID: geOa9zixMr2oS9yNhZ80xA_1779293332
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CCE4218002E0;
	Wed, 20 May 2026 16:08:52 +0000 (UTC)
Received: from rules.brq.redhat.com (unknown [10.44.22.28])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E13FB1681;
	Wed, 20 May 2026 16:08:50 +0000 (UTC)
From: Vladislav Dronov <vdronov@redhat.com>
To: herbert@gondor.apana.org.au
Cc: akhilrajeev@nvidia.com,
	linux-crypto@vger.kernel.org,
	ptalbert@redhat.com,
	vdronov@redhat.com
Subject: Re: [PATCH] crypto: tegra - Return ENOMEM when input buffer allocation fails for ccm
Date: Wed, 20 May 2026 18:08:34 +0200
Message-ID: <20260520160834.29721-1-vdronov@redhat.com>
In-Reply-To: <ag0houiGk0cLZ9ls@gondor.apana.org.au>
References: <ag0houiGk0cLZ9ls@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-24365-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vdronov@redhat.com,linux-crypto@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 8171E5919F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi, Herbert,
Thank you for this fix! Please feel free to use my:

Reviewed-by: Vladislav Dronov <vdronov@redhat.com>

Best regards,
Vladislav Dronov


