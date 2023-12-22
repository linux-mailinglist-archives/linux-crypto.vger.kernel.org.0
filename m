Return-Path: <linux-crypto+bounces-957-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CB781C34E
	for <lists+linux-crypto@lfdr.de>; Fri, 22 Dec 2023 04:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3B54285E7B
	for <lists+linux-crypto@lfdr.de>; Fri, 22 Dec 2023 03:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C69211C;
	Fri, 22 Dec 2023 03:16:01 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55640210B
	for <linux-crypto@vger.kernel.org>; Fri, 22 Dec 2023 03:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rGW0p-00DgWT-4o; Fri, 22 Dec 2023 11:15:48 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 22 Dec 2023 11:15:57 +0800
Date: Fri, 22 Dec 2023 11:15:57 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Horia =?iso-8859-1?Q?Geant=C4?= <horia.geanta@nxp.com>,
	Gaurav Jain <gaurav.jain@nxp.com>,
	Pankaj Gupta <pankaj.gupta@nxp.com>,
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Cc: Ondrej Mosnacek <omosnace@redhat.com>
Subject: caam test failures with libkcapi
Message-ID: <ZYT/beBEO7dAlVO2@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi:

It's been brought to my attention that the caam driver fails with
libkcapi test suite:

	https://github.com/smuellerDD/libkcapi/

Can you please have a look into this? It would also be useful to
get some confirmation that caam still passes the extra fuzzing
tests.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

