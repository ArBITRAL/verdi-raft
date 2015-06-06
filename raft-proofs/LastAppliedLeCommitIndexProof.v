Require Import List.
Import ListNotations.

Require Import VerdiTactics.
Require Import Util.
Require Import Net.

Require Import Raft.

Require Import LastAppliedLeCommitIndexInterface.

Section LastAppliedLeCommitIndex.
  Context {orig_base_params : BaseParams}.
  Context {one_node_params : OneNodeParams orig_base_params}.
  Context {raft_params : RaftParams orig_base_params}.

  Instance lalcii : lastApplied_le_commitIndex_interface.
  Admitted.

End LastAppliedLeCommitIndex.

