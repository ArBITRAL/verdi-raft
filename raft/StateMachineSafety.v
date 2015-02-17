Require Import List.
Import ListNotations.

Require Import Net.
Require Import Util.
Require Import VerdiTactics.

Require Import Raft.

Section StateMachineSafety.
  Context {orig_base_params : BaseParams}.
  Context {one_node_params : OneNodeParams orig_base_params}.
  Context {raft_params : RaftParams orig_base_params}.

  Definition state_machine_safety_host net :=
    forall h h' e e',
      eIndex e < lastApplied (nwState net h) ->
      In e (log (nwState net h)) ->
      eIndex e' < lastApplied (nwState net h') ->
      In e' (log (nwState net h')) ->
      eIndex e = eIndex e' ->
      e = e'.

  Definition state_machine_safety_nw net :=
    forall h p t leaderId prevLogIndex prevLogTerm entries leaderCommit e,
      In p (nwPackets net) ->
      pBody p = AppendEntries t leaderId prevLogIndex prevLogTerm
                              entries leaderCommit ->
      t >= currentTerm (nwState net h) ->
      eIndex e < lastApplied (nwState net h) ->
      (prevLogIndex > eIndex e \/
       In e entries).

  Definition state_machine_safety net :=
    state_machine_safety_host net /\ state_machine_safety_nw net.

  Theorem state_machine_safety_invariant :
    forall net,
      raft_intermediate_reachable net ->
      state_machine_safety net.
  Admitted.

End StateMachineSafety.
         
