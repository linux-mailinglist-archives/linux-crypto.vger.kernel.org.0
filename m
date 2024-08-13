Return-Path: <linux-crypto+bounces-5929-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79720950366
	for <lists+linux-crypto@lfdr.de>; Tue, 13 Aug 2024 13:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2AABB22D2C
	for <lists+linux-crypto@lfdr.de>; Tue, 13 Aug 2024 11:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF7913A879;
	Tue, 13 Aug 2024 11:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IjFs+06f"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D241C2233A
	for <linux-crypto@vger.kernel.org>; Tue, 13 Aug 2024 11:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723547730; cv=none; b=gL+uyTTq/Kx5/1mbN8g52gV5q7LV/48VqAx9Mgbcgzfg4ThFtalXzRKQ1Es5gb2vflVPvJQV1mQb2eVWaNjej3Ga9BbFolNuGUpPiCjnQG7f9/f5ZslwogYhfsyyV9OyCM4si+9cUHsCNwQprrR0K8o0Xgr2y5TI6m9ppR0aFxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723547730; c=relaxed/simple;
	bh=geyMkjNF+UiTEnQfr4PR13wFQ71eMS/kdrUZ6LndVD8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=InFmTW4jHwp0gnDmNJTlAaPPOzlkknrVLj/yKYsDCfXevZR+6EYT/l9s0es1tzfPzfdCV3EAnxX/rlGJ3+HrKdIOgaPwie2z7UwZmbCjnEKNJ1ysOih9YulW/Xw0qoBnRHDiSdWYUTdb0ZRCe+lvq3VSsFwZAls0ohPc/9IMncY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IjFs+06f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB14C4AF0B;
	Tue, 13 Aug 2024 11:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723547730;
	bh=geyMkjNF+UiTEnQfr4PR13wFQ71eMS/kdrUZ6LndVD8=;
	h=From:To:Cc:Subject:Date:From;
	b=IjFs+06fMAKoDA+AK4idqJOb0lPKTZ6Ty9DVjuUEQPFZ97Q4koMV3SFaPVe7ahXoG
	 u5mfNc/HOi4l4iEloEo93xo2XirzjlrnR2haSUjaa0cpI5eriBGZyZZdb8FjORYWlr
	 wg6uSSNr9RgX+Hfgcfk2hMAMzMIvg9+LxEcs+YCdUU9XfhTnF5V4KDQimx5ptsWtHu
	 ud7XdEDJwN6emdkI8XSu4cQt0SH2RAEye/ic3vNNF4cXWQ2GTInettAkj3GaTQbIdk
	 RJbw6eGsSGw7LqXV+vOpsq9NUhrH8AT1ib8Zx5mvgLHorWK6Lo81xLGEW6/ULGd1qh
	 JU40R3rA8NZLg==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Eric Biggers <ebiggers@kernel.org>,
	linux-crypto@vger.kernel.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCHv9 0/9] nvme: implement secure concatenation
Date: Tue, 13 Aug 2024 13:15:03 +0200
Message-Id: <20240813111512.135634-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

here's my attempt to implement secure concatenation for NVMe-of TCP
as outlined in TP8018.
The original (v5) patchset had been split in two, the first part of
which has already been merged with nvme-6.11, and this is the second part
which actually implements secure concatenation.

Secure concatenation means that a TLS PSK is generated from the key
material negotiated by the DH-HMAC-CHAP protocol, and the TLS PSK
is then used for a subsequent TLS connection.
The difference between the original definition of secure concatenation
and the method outlined in TP8018 is that with TP8018 the connection
is reset after DH-HMAC-CHAP negotiation, and a new connection is setup
with the generated TLS PSK.

To implement that Sagi came up with the idea to directly reset the
admin queue once the DH-CHAP negotiation has completed; that way
it will be transparent to the upper layers and we don't have to
worry about exposing queues which should not be used.

As usual, comments and reviews are welcome.

Patchset can be found at
git.kernel.org:/pub/scm/linux/kernel/git/hare/nvme.git
branch secure-concat.v9

Changes to v8:
- Include reviews from Eric Biggers
- Make hkdf a proper module
- Add testcases for hkdf

Changes to v7:
- Add patch to display nvme target TLS status in debugfs
- Include reviews from Sagi

Changes to v6:
- Rebase to nvme-6.11

Changes to v5:
- Include reviews from Sagi
- Split patchset in two parts

Changes to v4:
- Rework reset admin queue functionality based on an idea
  from Sagi (thanks!)
  - kbuild robot fixes
  - Fixup dhchap negotiation with non-empty C2 value

Changes to v3:
- Include reviews from Sagi
- Do not start I/O queues after DH-HMAC-CHAP negotiation
- Use bool to indicate TLS has been enabled on a queue
- Add 'tls_keyring' sysfs attribute
- Add 'tls_configured_key' sysfs attribute

Changes to v2:
- Fixup reset after dhchap negotiation
- Disable namespace scanning on I/O queues after
  dhchap negotiation
        - Reworked TLS key handling (again)

Changes to the original submission:
- Sanitize TLS key handling
- Fixup modconfig compilation

Hannes Reinecke (9):
  crypto,fs: Separate out hkdf_extract() and hkdf_expand()
  nvme: add nvme_auth_generate_psk()
  nvme: add nvme_auth_generate_digest()
  nvme: add nvme_auth_derive_tls_psk()
  nvme-keyring: add nvme_tls_psk_refresh()
  nvme-tcp: request secure channel concatenation
  nvme-fabrics: reset admin connection for secure concatenation
  nvmet-tcp: support secure channel concatenation
  nvmet: add tls_concat and tls_key debugfs entries

 crypto/Kconfig                         |   4 +
 crypto/Makefile                        |   1 +
 crypto/hkdf.c                          | 404 +++++++++++++++++++++++++
 drivers/nvme/common/Kconfig            |   1 +
 drivers/nvme/common/auth.c             | 344 +++++++++++++++++++++
 drivers/nvme/common/keyring.c          |  64 ++++
 drivers/nvme/host/auth.c               | 108 ++++++-
 drivers/nvme/host/fabrics.c            |  34 ++-
 drivers/nvme/host/fabrics.h            |   3 +
 drivers/nvme/host/nvme.h               |   2 +
 drivers/nvme/host/sysfs.c              |   4 +-
 drivers/nvme/host/tcp.c                |  56 +++-
 drivers/nvme/target/auth.c             |  72 ++++-
 drivers/nvme/target/debugfs.c          |  27 ++
 drivers/nvme/target/fabrics-cmd-auth.c |  49 ++-
 drivers/nvme/target/fabrics-cmd.c      |  33 +-
 drivers/nvme/target/nvmet.h            |  38 ++-
 drivers/nvme/target/tcp.c              |  23 +-
 fs/crypto/Kconfig                      |   1 +
 fs/crypto/hkdf.c                       |  87 +-----
 include/crypto/hkdf.h                  |  34 +++
 include/linux/nvme-auth.h              |   7 +
 include/linux/nvme-keyring.h           |   9 +
 include/linux/nvme.h                   |   7 +
 24 files changed, 1303 insertions(+), 109 deletions(-)
 create mode 100644 crypto/hkdf.c
 create mode 100644 include/crypto/hkdf.h

-- 
2.35.3


