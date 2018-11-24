{- This file was auto-generated from karps/proto/std.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies,
  UndecidableInstances, MultiParamTypeClasses, FlexibleContexts,
  FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude
  #-}
{-# OPTIONS_GHC -fno-warn-unused-imports #-}
module Proto.Karps.Proto.Std where
import qualified Data.ProtoLens.Reexport.Prelude as Prelude
import qualified Data.ProtoLens.Reexport.Data.Int as Data.Int
import qualified Data.ProtoLens.Reexport.Data.Word as Data.Word
import qualified Data.ProtoLens.Reexport.Data.ProtoLens
       as Data.ProtoLens
import qualified
       Data.ProtoLens.Reexport.Data.ProtoLens.Message.Enum
       as Data.ProtoLens.Message.Enum
import qualified Data.ProtoLens.Reexport.Lens.Family2
       as Lens.Family2
import qualified Data.ProtoLens.Reexport.Lens.Family2.Unchecked
       as Lens.Family2.Unchecked
import qualified Data.ProtoLens.Reexport.Data.Default.Class
       as Data.Default.Class
import qualified Data.ProtoLens.Reexport.Data.Text as Data.Text
import qualified Data.ProtoLens.Reexport.Data.Map as Data.Map
import qualified Data.ProtoLens.Reexport.Data.ByteString
       as Data.ByteString
import qualified Data.ProtoLens.Reexport.Lens.Labels as Lens.Labels
import qualified Proto.Karps.Proto.Computation
import qualified Proto.Karps.Proto.Graph
import qualified Proto.Karps.Proto.StructuredTransform
import qualified Proto.Karps.Proto.Types

data Join = Join{_Join'jointType :: !Join'JoinType}
          deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance (a ~ Join'JoinType, b ~ Join'JoinType,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "jointType" f Join Join a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Join'jointType
                 (\ x__ y__ -> x__{_Join'jointType = y__}))
              Prelude.id

instance Data.Default.Class.Default Join where
        def = Join{_Join'jointType = Data.Default.Class.def}

instance Data.ProtoLens.Message Join where
        descriptor
          = let jointType__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "joint_type"
                      (Data.ProtoLens.EnumField ::
                         Data.ProtoLens.FieldTypeDescriptor Join'JoinType)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional jointType)
                      :: Data.ProtoLens.FieldDescriptor Join
              in
              Data.ProtoLens.MessageDescriptor (Data.Text.pack "karps.core.Join")
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, jointType__field_descriptor)])
                (Data.Map.fromList [("joint_type", jointType__field_descriptor)])

data Join'JoinType = Join'INNER
                   deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance Data.Default.Class.Default Join'JoinType where
        def = Join'INNER

instance Data.ProtoLens.FieldDefault Join'JoinType where
        fieldDefault = Join'INNER

instance Data.ProtoLens.MessageEnum Join'JoinType where
        maybeToEnum 0 = Prelude.Just Join'INNER
        maybeToEnum _ = Prelude.Nothing
        showEnum Join'INNER = "INNER"
        readEnum "INNER" = Prelude.Just Join'INNER
        readEnum _ = Prelude.Nothing

instance Prelude.Enum Join'JoinType where
        toEnum k__
          = Prelude.maybe
              (Prelude.error
                 ((Prelude.++) "toEnum: unknown value for enum JoinType: "
                    (Prelude.show k__)))
              Prelude.id
              (Data.ProtoLens.maybeToEnum k__)
        fromEnum Join'INNER = 0
        succ Join'INNER
          = Prelude.error
              "Join'JoinType.succ: bad argument Join'INNER. This value would be out of bounds."
        pred Join'INNER
          = Prelude.error
              "Join'JoinType.pred: bad argument Join'INNER. This value would be out of bounds."
        enumFrom = Data.ProtoLens.Message.Enum.messageEnumFrom
        enumFromTo = Data.ProtoLens.Message.Enum.messageEnumFromTo
        enumFromThen = Data.ProtoLens.Message.Enum.messageEnumFromThen
        enumFromThenTo = Data.ProtoLens.Message.Enum.messageEnumFromThenTo

instance Prelude.Bounded Join'JoinType where
        minBound = Join'INNER
        maxBound = Join'INNER

data LocalPointer = LocalPointer{_LocalPointer'computation ::
                                 !(Prelude.Maybe Proto.Karps.Proto.Computation.ComputationId),
                                 _LocalPointer'localPath ::
                                 !(Prelude.Maybe Proto.Karps.Proto.Graph.Path),
                                 _LocalPointer'dataType ::
                                 !(Prelude.Maybe Proto.Karps.Proto.Types.SQLType)}
                  deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance (a ~ Proto.Karps.Proto.Computation.ComputationId,
          b ~ Proto.Karps.Proto.Computation.ComputationId,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "computation" f LocalPointer LocalPointer a b
         where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _LocalPointer'computation
                 (\ x__ y__ -> x__{_LocalPointer'computation = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~
            Prelude.Maybe Proto.Karps.Proto.Computation.ComputationId,
          b ~ Prelude.Maybe Proto.Karps.Proto.Computation.ComputationId,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'computation" f LocalPointer LocalPointer
         a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _LocalPointer'computation
                 (\ x__ y__ -> x__{_LocalPointer'computation = y__}))
              Prelude.id

instance (a ~ Proto.Karps.Proto.Graph.Path,
          b ~ Proto.Karps.Proto.Graph.Path, Prelude.Functor f) =>
         Lens.Labels.HasLens "localPath" f LocalPointer LocalPointer a b
         where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _LocalPointer'localPath
                 (\ x__ y__ -> x__{_LocalPointer'localPath = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~ Prelude.Maybe Proto.Karps.Proto.Graph.Path,
          b ~ Prelude.Maybe Proto.Karps.Proto.Graph.Path,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'localPath" f LocalPointer LocalPointer a
         b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _LocalPointer'localPath
                 (\ x__ y__ -> x__{_LocalPointer'localPath = y__}))
              Prelude.id

instance (a ~ Proto.Karps.Proto.Types.SQLType,
          b ~ Proto.Karps.Proto.Types.SQLType, Prelude.Functor f) =>
         Lens.Labels.HasLens "dataType" f LocalPointer LocalPointer a b
         where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _LocalPointer'dataType
                 (\ x__ y__ -> x__{_LocalPointer'dataType = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~ Prelude.Maybe Proto.Karps.Proto.Types.SQLType,
          b ~ Prelude.Maybe Proto.Karps.Proto.Types.SQLType,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'dataType" f LocalPointer LocalPointer a
         b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _LocalPointer'dataType
                 (\ x__ y__ -> x__{_LocalPointer'dataType = y__}))
              Prelude.id

instance Data.Default.Class.Default LocalPointer where
        def
          = LocalPointer{_LocalPointer'computation = Prelude.Nothing,
                         _LocalPointer'localPath = Prelude.Nothing,
                         _LocalPointer'dataType = Prelude.Nothing}

instance Data.ProtoLens.Message LocalPointer where
        descriptor
          = let computation__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "computation"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor
                           Proto.Karps.Proto.Computation.ComputationId)
                      (Data.ProtoLens.OptionalField maybe'computation)
                      :: Data.ProtoLens.FieldDescriptor LocalPointer
                localPath__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "local_path"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor Proto.Karps.Proto.Graph.Path)
                      (Data.ProtoLens.OptionalField maybe'localPath)
                      :: Data.ProtoLens.FieldDescriptor LocalPointer
                dataType__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "data_type"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor Proto.Karps.Proto.Types.SQLType)
                      (Data.ProtoLens.OptionalField maybe'dataType)
                      :: Data.ProtoLens.FieldDescriptor LocalPointer
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Text.pack "karps.core.LocalPointer")
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, computation__field_descriptor),
                    (Data.ProtoLens.Tag 2, localPath__field_descriptor),
                    (Data.ProtoLens.Tag 4, dataType__field_descriptor)])
                (Data.Map.fromList
                   [("computation", computation__field_descriptor),
                    ("local_path", localPath__field_descriptor),
                    ("data_type", dataType__field_descriptor)])

data LocalStructuredTransform = LocalStructuredTransform{_LocalStructuredTransform'colOp
                                                         ::
                                                         !(Prelude.Maybe
                                                             Proto.Karps.Proto.StructuredTransform.Column)}
                              deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance (a ~ Proto.Karps.Proto.StructuredTransform.Column,
          b ~ Proto.Karps.Proto.StructuredTransform.Column,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "colOp" f LocalStructuredTransform
         LocalStructuredTransform a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _LocalStructuredTransform'colOp
                 (\ x__ y__ -> x__{_LocalStructuredTransform'colOp = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~
            Prelude.Maybe Proto.Karps.Proto.StructuredTransform.Column,
          b ~ Prelude.Maybe Proto.Karps.Proto.StructuredTransform.Column,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'colOp" f LocalStructuredTransform
         LocalStructuredTransform a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _LocalStructuredTransform'colOp
                 (\ x__ y__ -> x__{_LocalStructuredTransform'colOp = y__}))
              Prelude.id

instance Data.Default.Class.Default LocalStructuredTransform where
        def
          = LocalStructuredTransform{_LocalStructuredTransform'colOp =
                                       Prelude.Nothing}

instance Data.ProtoLens.Message LocalStructuredTransform where
        descriptor
          = let colOp__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "col_op"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor
                           Proto.Karps.Proto.StructuredTransform.Column)
                      (Data.ProtoLens.OptionalField maybe'colOp)
                      :: Data.ProtoLens.FieldDescriptor LocalStructuredTransform
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Text.pack "karps.core.LocalStructuredTransform")
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, colOp__field_descriptor)])
                (Data.Map.fromList [("col_op", colOp__field_descriptor)])

data Placeholder = Placeholder{_Placeholder'locality ::
                               !Proto.Karps.Proto.Graph.Locality,
                               _Placeholder'dataType ::
                               !(Prelude.Maybe Proto.Karps.Proto.Types.SQLType)}
                 deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance (a ~ Proto.Karps.Proto.Graph.Locality,
          b ~ Proto.Karps.Proto.Graph.Locality, Prelude.Functor f) =>
         Lens.Labels.HasLens "locality" f Placeholder Placeholder a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Placeholder'locality
                 (\ x__ y__ -> x__{_Placeholder'locality = y__}))
              Prelude.id

instance (a ~ Proto.Karps.Proto.Types.SQLType,
          b ~ Proto.Karps.Proto.Types.SQLType, Prelude.Functor f) =>
         Lens.Labels.HasLens "dataType" f Placeholder Placeholder a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Placeholder'dataType
                 (\ x__ y__ -> x__{_Placeholder'dataType = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~ Prelude.Maybe Proto.Karps.Proto.Types.SQLType,
          b ~ Prelude.Maybe Proto.Karps.Proto.Types.SQLType,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'dataType" f Placeholder Placeholder a b
         where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Placeholder'dataType
                 (\ x__ y__ -> x__{_Placeholder'dataType = y__}))
              Prelude.id

instance Data.Default.Class.Default Placeholder where
        def
          = Placeholder{_Placeholder'locality = Data.Default.Class.def,
                        _Placeholder'dataType = Prelude.Nothing}

instance Data.ProtoLens.Message Placeholder where
        descriptor
          = let locality__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "locality"
                      (Data.ProtoLens.EnumField ::
                         Data.ProtoLens.FieldTypeDescriptor
                           Proto.Karps.Proto.Graph.Locality)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional locality)
                      :: Data.ProtoLens.FieldDescriptor Placeholder
                dataType__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "data_type"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor Proto.Karps.Proto.Types.SQLType)
                      (Data.ProtoLens.OptionalField maybe'dataType)
                      :: Data.ProtoLens.FieldDescriptor Placeholder
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Text.pack "karps.core.Placeholder")
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, locality__field_descriptor),
                    (Data.ProtoLens.Tag 2, dataType__field_descriptor)])
                (Data.Map.fromList
                   [("locality", locality__field_descriptor),
                    ("data_type", dataType__field_descriptor)])

data Shuffle = Shuffle{_Shuffle'aggOp ::
                       !(Prelude.Maybe Proto.Karps.Proto.StructuredTransform.Aggregation)}
             deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance (a ~ Proto.Karps.Proto.StructuredTransform.Aggregation,
          b ~ Proto.Karps.Proto.StructuredTransform.Aggregation,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "aggOp" f Shuffle Shuffle a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Shuffle'aggOp
                 (\ x__ y__ -> x__{_Shuffle'aggOp = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~
            Prelude.Maybe Proto.Karps.Proto.StructuredTransform.Aggregation,
          b ~
            Prelude.Maybe Proto.Karps.Proto.StructuredTransform.Aggregation,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'aggOp" f Shuffle Shuffle a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Shuffle'aggOp
                 (\ x__ y__ -> x__{_Shuffle'aggOp = y__}))
              Prelude.id

instance Data.Default.Class.Default Shuffle where
        def = Shuffle{_Shuffle'aggOp = Prelude.Nothing}

instance Data.ProtoLens.Message Shuffle where
        descriptor
          = let aggOp__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "agg_op"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor
                           Proto.Karps.Proto.StructuredTransform.Aggregation)
                      (Data.ProtoLens.OptionalField maybe'aggOp)
                      :: Data.ProtoLens.FieldDescriptor Shuffle
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Text.pack "karps.core.Shuffle")
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, aggOp__field_descriptor)])
                (Data.Map.fromList [("agg_op", aggOp__field_descriptor)])

data StructuredReduce = StructuredReduce{_StructuredReduce'aggOp ::
                                         !(Prelude.Maybe
                                             Proto.Karps.Proto.StructuredTransform.Aggregation)}
                      deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance (a ~ Proto.Karps.Proto.StructuredTransform.Aggregation,
          b ~ Proto.Karps.Proto.StructuredTransform.Aggregation,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "aggOp" f StructuredReduce StructuredReduce a b
         where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _StructuredReduce'aggOp
                 (\ x__ y__ -> x__{_StructuredReduce'aggOp = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~
            Prelude.Maybe Proto.Karps.Proto.StructuredTransform.Aggregation,
          b ~
            Prelude.Maybe Proto.Karps.Proto.StructuredTransform.Aggregation,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'aggOp" f StructuredReduce
         StructuredReduce a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _StructuredReduce'aggOp
                 (\ x__ y__ -> x__{_StructuredReduce'aggOp = y__}))
              Prelude.id

instance Data.Default.Class.Default StructuredReduce where
        def = StructuredReduce{_StructuredReduce'aggOp = Prelude.Nothing}

instance Data.ProtoLens.Message StructuredReduce where
        descriptor
          = let aggOp__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "agg_op"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor
                           Proto.Karps.Proto.StructuredTransform.Aggregation)
                      (Data.ProtoLens.OptionalField maybe'aggOp)
                      :: Data.ProtoLens.FieldDescriptor StructuredReduce
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Text.pack "karps.core.StructuredReduce")
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, aggOp__field_descriptor)])
                (Data.Map.fromList [("agg_op", aggOp__field_descriptor)])

data StructuredTransform = StructuredTransform{_StructuredTransform'colOp
                                               ::
                                               !(Prelude.Maybe
                                                   Proto.Karps.Proto.StructuredTransform.Column)}
                         deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance (a ~ Proto.Karps.Proto.StructuredTransform.Column,
          b ~ Proto.Karps.Proto.StructuredTransform.Column,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "colOp" f StructuredTransform
         StructuredTransform a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _StructuredTransform'colOp
                 (\ x__ y__ -> x__{_StructuredTransform'colOp = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~
            Prelude.Maybe Proto.Karps.Proto.StructuredTransform.Column,
          b ~ Prelude.Maybe Proto.Karps.Proto.StructuredTransform.Column,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'colOp" f StructuredTransform
         StructuredTransform a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _StructuredTransform'colOp
                 (\ x__ y__ -> x__{_StructuredTransform'colOp = y__}))
              Prelude.id

instance Data.Default.Class.Default StructuredTransform where
        def
          = StructuredTransform{_StructuredTransform'colOp = Prelude.Nothing}

instance Data.ProtoLens.Message StructuredTransform where
        descriptor
          = let colOp__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "col_op"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor
                           Proto.Karps.Proto.StructuredTransform.Column)
                      (Data.ProtoLens.OptionalField maybe'colOp)
                      :: Data.ProtoLens.FieldDescriptor StructuredTransform
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Text.pack "karps.core.StructuredTransform")
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, colOp__field_descriptor)])
                (Data.Map.fromList [("col_op", colOp__field_descriptor)])

aggOp ::
      forall f s t a b . Lens.Labels.HasLens "aggOp" f s t a b =>
        Lens.Family2.LensLike f s t a b
aggOp
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "aggOp")

colOp ::
      forall f s t a b . Lens.Labels.HasLens "colOp" f s t a b =>
        Lens.Family2.LensLike f s t a b
colOp
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "colOp")

computation ::
            forall f s t a b . Lens.Labels.HasLens "computation" f s t a b =>
              Lens.Family2.LensLike f s t a b
computation
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "computation")

dataType ::
         forall f s t a b . Lens.Labels.HasLens "dataType" f s t a b =>
           Lens.Family2.LensLike f s t a b
dataType
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "dataType")

jointType ::
          forall f s t a b . Lens.Labels.HasLens "jointType" f s t a b =>
            Lens.Family2.LensLike f s t a b
jointType
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "jointType")

localPath ::
          forall f s t a b . Lens.Labels.HasLens "localPath" f s t a b =>
            Lens.Family2.LensLike f s t a b
localPath
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "localPath")

locality ::
         forall f s t a b . Lens.Labels.HasLens "locality" f s t a b =>
           Lens.Family2.LensLike f s t a b
locality
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "locality")

maybe'aggOp ::
            forall f s t a b . Lens.Labels.HasLens "maybe'aggOp" f s t a b =>
              Lens.Family2.LensLike f s t a b
maybe'aggOp
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'aggOp")

maybe'colOp ::
            forall f s t a b . Lens.Labels.HasLens "maybe'colOp" f s t a b =>
              Lens.Family2.LensLike f s t a b
maybe'colOp
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'colOp")

maybe'computation ::
                  forall f s t a b .
                    Lens.Labels.HasLens "maybe'computation" f s t a b =>
                    Lens.Family2.LensLike f s t a b
maybe'computation
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'computation")

maybe'dataType ::
               forall f s t a b .
                 Lens.Labels.HasLens "maybe'dataType" f s t a b =>
                 Lens.Family2.LensLike f s t a b
maybe'dataType
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'dataType")

maybe'localPath ::
                forall f s t a b .
                  Lens.Labels.HasLens "maybe'localPath" f s t a b =>
                  Lens.Family2.LensLike f s t a b
maybe'localPath
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'localPath")