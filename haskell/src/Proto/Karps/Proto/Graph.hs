{- This file was auto-generated from karps/proto/graph.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies,
  UndecidableInstances, GeneralizedNewtypeDeriving,
  MultiParamTypeClasses, FlexibleContexts, FlexibleInstances,
  PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds #-}
{-# OPTIONS_GHC -fno-warn-unused-imports#-}
{-# OPTIONS_GHC -fno-warn-duplicate-exports#-}
module Proto.Karps.Proto.Graph
       (CompilationPhaseGraph(..), Graph(..), Locality(..), Locality(),
        Locality'UnrecognizedValue, Node(..), OpExtra(..), Path(..))
       where
import qualified Data.ProtoLens.Reexport.Lens.Labels.Prism
       as Lens.Labels.Prism
import qualified Data.ProtoLens.Reexport.Prelude as Prelude
import qualified Data.ProtoLens.Reexport.Data.Int as Data.Int
import qualified Data.ProtoLens.Reexport.Data.Word as Data.Word
import qualified Data.ProtoLens.Reexport.Data.ProtoLens
       as Data.ProtoLens
import qualified
       Data.ProtoLens.Reexport.Data.ProtoLens.Message.Enum
       as Data.ProtoLens.Message.Enum
import qualified
       Data.ProtoLens.Reexport.Data.ProtoLens.Service.Types
       as Data.ProtoLens.Service.Types
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
import qualified Data.ProtoLens.Reexport.Data.ByteString.Char8
       as Data.ByteString.Char8
import qualified Data.ProtoLens.Reexport.Lens.Labels as Lens.Labels
import qualified Data.ProtoLens.Reexport.Text.Read as Text.Read
import qualified Proto.Karps.Proto.Types
import qualified Proto.Tensorflow.Core.Framework.Graph

{- | Fields :

    * 'Proto.Karps.Proto.Graph_Fields.phaseName' @:: Lens' CompilationPhaseGraph Data.Text.Text@
    * 'Proto.Karps.Proto.Graph_Fields.graph' @:: Lens' CompilationPhaseGraph Graph@
    * 'Proto.Karps.Proto.Graph_Fields.maybe'graph' @:: Lens' CompilationPhaseGraph (Prelude.Maybe Graph)@
    * 'Proto.Karps.Proto.Graph_Fields.graphTensorboardRepr' @:: Lens' CompilationPhaseGraph Data.Text.Text@
    * 'Proto.Karps.Proto.Graph_Fields.errorMessage' @:: Lens' CompilationPhaseGraph Data.Text.Text@
    * 'Proto.Karps.Proto.Graph_Fields.graphDef' @:: Lens' CompilationPhaseGraph
  Proto.Tensorflow.Core.Framework.Graph.GraphDef@
    * 'Proto.Karps.Proto.Graph_Fields.maybe'graphDef' @:: Lens' CompilationPhaseGraph
  (Prelude.Maybe Proto.Tensorflow.Core.Framework.Graph.GraphDef)@
 -}
data CompilationPhaseGraph = CompilationPhaseGraph{_CompilationPhaseGraph'phaseName
                                                   :: !Data.Text.Text,
                                                   _CompilationPhaseGraph'graph ::
                                                   !(Prelude.Maybe Graph),
                                                   _CompilationPhaseGraph'graphTensorboardRepr ::
                                                   !Data.Text.Text,
                                                   _CompilationPhaseGraph'errorMessage ::
                                                   !Data.Text.Text,
                                                   _CompilationPhaseGraph'graphDef ::
                                                   !(Prelude.Maybe
                                                       Proto.Tensorflow.Core.Framework.Graph.GraphDef),
                                                   _CompilationPhaseGraph'_unknownFields ::
                                                   !Data.ProtoLens.FieldSet}
                               deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f CompilationPhaseGraph x a,
          a ~ b) =>
         Lens.Labels.HasLens f CompilationPhaseGraph CompilationPhaseGraph x
           a
           b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f CompilationPhaseGraph "phaseName"
           (Data.Text.Text)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _CompilationPhaseGraph'phaseName
                 (\ x__ y__ -> x__{_CompilationPhaseGraph'phaseName = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f CompilationPhaseGraph "graph" (Graph)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _CompilationPhaseGraph'graph
                 (\ x__ y__ -> x__{_CompilationPhaseGraph'graph = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f CompilationPhaseGraph "maybe'graph"
           (Prelude.Maybe Graph)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _CompilationPhaseGraph'graph
                 (\ x__ y__ -> x__{_CompilationPhaseGraph'graph = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f CompilationPhaseGraph "graphTensorboardRepr"
           (Data.Text.Text)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens
                 _CompilationPhaseGraph'graphTensorboardRepr
                 (\ x__ y__ ->
                    x__{_CompilationPhaseGraph'graphTensorboardRepr = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f CompilationPhaseGraph "errorMessage"
           (Data.Text.Text)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _CompilationPhaseGraph'errorMessage
                 (\ x__ y__ -> x__{_CompilationPhaseGraph'errorMessage = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f CompilationPhaseGraph "graphDef"
           (Proto.Tensorflow.Core.Framework.Graph.GraphDef)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _CompilationPhaseGraph'graphDef
                 (\ x__ y__ -> x__{_CompilationPhaseGraph'graphDef = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f CompilationPhaseGraph "maybe'graphDef"
           (Prelude.Maybe Proto.Tensorflow.Core.Framework.Graph.GraphDef)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _CompilationPhaseGraph'graphDef
                 (\ x__ y__ -> x__{_CompilationPhaseGraph'graphDef = y__}))
              Prelude.id
instance Data.Default.Class.Default CompilationPhaseGraph where
        def
          = CompilationPhaseGraph{_CompilationPhaseGraph'phaseName =
                                    Data.ProtoLens.fieldDefault,
                                  _CompilationPhaseGraph'graph = Prelude.Nothing,
                                  _CompilationPhaseGraph'graphTensorboardRepr =
                                    Data.ProtoLens.fieldDefault,
                                  _CompilationPhaseGraph'errorMessage = Data.ProtoLens.fieldDefault,
                                  _CompilationPhaseGraph'graphDef = Prelude.Nothing,
                                  _CompilationPhaseGraph'_unknownFields = ([])}
instance Data.ProtoLens.Message CompilationPhaseGraph where
        messageName _ = Data.Text.pack "karps.core.CompilationPhaseGraph"
        fieldsByTag
          = let phaseName__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "phase_name"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "phaseName")))
                      :: Data.ProtoLens.FieldDescriptor CompilationPhaseGraph
                graph__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "graph"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor Graph)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'graph")))
                      :: Data.ProtoLens.FieldDescriptor CompilationPhaseGraph
                graphTensorboardRepr__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "graph_tensorboard_repr"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) ::
                               (Lens.Labels.Proxy#) "graphTensorboardRepr")))
                      :: Data.ProtoLens.FieldDescriptor CompilationPhaseGraph
                errorMessage__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "error_message"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "errorMessage")))
                      :: Data.ProtoLens.FieldDescriptor CompilationPhaseGraph
                graphDef__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "graph_def"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor
                           Proto.Tensorflow.Core.Framework.Graph.GraphDef)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'graphDef")))
                      :: Data.ProtoLens.FieldDescriptor CompilationPhaseGraph
              in
              Data.Map.fromList
                [(Data.ProtoLens.Tag 1, phaseName__field_descriptor),
                 (Data.ProtoLens.Tag 2, graph__field_descriptor),
                 (Data.ProtoLens.Tag 3, graphTensorboardRepr__field_descriptor),
                 (Data.ProtoLens.Tag 4, errorMessage__field_descriptor),
                 (Data.ProtoLens.Tag 5, graphDef__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens _CompilationPhaseGraph'_unknownFields
              (\ x__ y__ -> x__{_CompilationPhaseGraph'_unknownFields = y__})
{- | Fields :

    * 'Proto.Karps.Proto.Graph_Fields.nodes' @:: Lens' Graph [Node]@
 -}
data Graph = Graph{_Graph'nodes :: ![Node],
                   _Graph'_unknownFields :: !Data.ProtoLens.FieldSet}
               deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f Graph x a, a ~ b) =>
         Lens.Labels.HasLens f Graph Graph x a b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f Graph "nodes" ([Node])
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Graph'nodes
                 (\ x__ y__ -> x__{_Graph'nodes = y__}))
              Prelude.id
instance Data.Default.Class.Default Graph where
        def = Graph{_Graph'nodes = [], _Graph'_unknownFields = ([])}
instance Data.ProtoLens.Message Graph where
        messageName _ = Data.Text.pack "karps.core.Graph"
        fieldsByTag
          = let nodes__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "nodes"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor Node)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "nodes")))
                      :: Data.ProtoLens.FieldDescriptor Graph
              in
              Data.Map.fromList [(Data.ProtoLens.Tag 1, nodes__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens _Graph'_unknownFields
              (\ x__ y__ -> x__{_Graph'_unknownFields = y__})
data Locality = LOCAL
              | DISTRIBUTED
              | Locality'Unrecognized !Locality'UnrecognizedValue
                  deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
newtype Locality'UnrecognizedValue = Locality'UnrecognizedValue Data.Int.Int32
                                       deriving (Prelude.Eq, Prelude.Ord, Prelude.Show)
instance Data.ProtoLens.MessageEnum Locality where
        maybeToEnum 0 = Prelude.Just LOCAL
        maybeToEnum 1 = Prelude.Just DISTRIBUTED
        maybeToEnum k
          = Prelude.Just
              (Locality'Unrecognized
                 (Locality'UnrecognizedValue (Prelude.fromIntegral k)))
        showEnum LOCAL = "LOCAL"
        showEnum DISTRIBUTED = "DISTRIBUTED"
        showEnum (Locality'Unrecognized (Locality'UnrecognizedValue k))
          = Prelude.show k
        readEnum "LOCAL" = Prelude.Just LOCAL
        readEnum "DISTRIBUTED" = Prelude.Just DISTRIBUTED
        readEnum k
          = (Prelude.>>=) (Text.Read.readMaybe k) Data.ProtoLens.maybeToEnum
instance Prelude.Bounded Locality where
        minBound = LOCAL
        maxBound = DISTRIBUTED
instance Prelude.Enum Locality where
        toEnum k__
          = Prelude.maybe
              (Prelude.error
                 ((Prelude.++) "toEnum: unknown value for enum Locality: "
                    (Prelude.show k__)))
              Prelude.id
              (Data.ProtoLens.maybeToEnum k__)
        fromEnum LOCAL = 0
        fromEnum DISTRIBUTED = 1
        fromEnum (Locality'Unrecognized (Locality'UnrecognizedValue k))
          = Prelude.fromIntegral k
        succ DISTRIBUTED
          = Prelude.error
              "Locality.succ: bad argument DISTRIBUTED. This value would be out of bounds."
        succ LOCAL = DISTRIBUTED
        succ _
          = Prelude.error "Locality.succ: bad argument: unrecognized value"
        pred LOCAL
          = Prelude.error
              "Locality.pred: bad argument LOCAL. This value would be out of bounds."
        pred DISTRIBUTED = LOCAL
        pred _
          = Prelude.error "Locality.pred: bad argument: unrecognized value"
        enumFrom = Data.ProtoLens.Message.Enum.messageEnumFrom
        enumFromTo = Data.ProtoLens.Message.Enum.messageEnumFromTo
        enumFromThen = Data.ProtoLens.Message.Enum.messageEnumFromThen
        enumFromThenTo = Data.ProtoLens.Message.Enum.messageEnumFromThenTo
instance Data.Default.Class.Default Locality where
        def = LOCAL
instance Data.ProtoLens.FieldDefault Locality where
        fieldDefault = LOCAL
{- | Fields :

    * 'Proto.Karps.Proto.Graph_Fields.locality' @:: Lens' Node Locality@
    * 'Proto.Karps.Proto.Graph_Fields.path' @:: Lens' Node Path@
    * 'Proto.Karps.Proto.Graph_Fields.maybe'path' @:: Lens' Node (Prelude.Maybe Path)@
    * 'Proto.Karps.Proto.Graph_Fields.opName' @:: Lens' Node Data.Text.Text@
    * 'Proto.Karps.Proto.Graph_Fields.opExtra' @:: Lens' Node OpExtra@
    * 'Proto.Karps.Proto.Graph_Fields.maybe'opExtra' @:: Lens' Node (Prelude.Maybe OpExtra)@
    * 'Proto.Karps.Proto.Graph_Fields.parents' @:: Lens' Node [Path]@
    * 'Proto.Karps.Proto.Graph_Fields.logicalDependencies' @:: Lens' Node [Path]@
    * 'Proto.Karps.Proto.Graph_Fields.inferedType' @:: Lens' Node Proto.Karps.Proto.Types.SQLType@
    * 'Proto.Karps.Proto.Graph_Fields.maybe'inferedType' @:: Lens' Node (Prelude.Maybe Proto.Karps.Proto.Types.SQLType)@
 -}
data Node = Node{_Node'locality :: !Locality,
                 _Node'path :: !(Prelude.Maybe Path),
                 _Node'opName :: !Data.Text.Text,
                 _Node'opExtra :: !(Prelude.Maybe OpExtra),
                 _Node'parents :: ![Path], _Node'logicalDependencies :: ![Path],
                 _Node'inferedType ::
                 !(Prelude.Maybe Proto.Karps.Proto.Types.SQLType),
                 _Node'_unknownFields :: !Data.ProtoLens.FieldSet}
              deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f Node x a, a ~ b) =>
         Lens.Labels.HasLens f Node Node x a b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f Node "locality" (Locality)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Node'locality
                 (\ x__ y__ -> x__{_Node'locality = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f Node "path" (Path)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Node'path
                 (\ x__ y__ -> x__{_Node'path = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f Node "maybe'path" (Prelude.Maybe Path)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Node'path
                 (\ x__ y__ -> x__{_Node'path = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f Node "opName" (Data.Text.Text)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Node'opName
                 (\ x__ y__ -> x__{_Node'opName = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f Node "opExtra" (OpExtra)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Node'opExtra
                 (\ x__ y__ -> x__{_Node'opExtra = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f Node "maybe'opExtra" (Prelude.Maybe OpExtra)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Node'opExtra
                 (\ x__ y__ -> x__{_Node'opExtra = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f Node "parents" ([Path])
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Node'parents
                 (\ x__ y__ -> x__{_Node'parents = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f Node "logicalDependencies" ([Path])
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Node'logicalDependencies
                 (\ x__ y__ -> x__{_Node'logicalDependencies = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f Node "inferedType"
           (Proto.Karps.Proto.Types.SQLType)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Node'inferedType
                 (\ x__ y__ -> x__{_Node'inferedType = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f Node "maybe'inferedType"
           (Prelude.Maybe Proto.Karps.Proto.Types.SQLType)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Node'inferedType
                 (\ x__ y__ -> x__{_Node'inferedType = y__}))
              Prelude.id
instance Data.Default.Class.Default Node where
        def
          = Node{_Node'locality = Data.Default.Class.def,
                 _Node'path = Prelude.Nothing,
                 _Node'opName = Data.ProtoLens.fieldDefault,
                 _Node'opExtra = Prelude.Nothing, _Node'parents = [],
                 _Node'logicalDependencies = [],
                 _Node'inferedType = Prelude.Nothing, _Node'_unknownFields = ([])}
instance Data.ProtoLens.Message Node where
        messageName _ = Data.Text.pack "karps.core.Node"
        fieldsByTag
          = let locality__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "locality"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.EnumField ::
                         Data.ProtoLens.FieldTypeDescriptor Locality)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "locality")))
                      :: Data.ProtoLens.FieldDescriptor Node
                path__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "path"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor Path)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'path")))
                      :: Data.ProtoLens.FieldDescriptor Node
                opName__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "op_name"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "opName")))
                      :: Data.ProtoLens.FieldDescriptor Node
                opExtra__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "op_extra"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor OpExtra)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'opExtra")))
                      :: Data.ProtoLens.FieldDescriptor Node
                parents__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "parents"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor Path)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "parents")))
                      :: Data.ProtoLens.FieldDescriptor Node
                logicalDependencies__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "logical_dependencies"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor Path)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) ::
                               (Lens.Labels.Proxy#) "logicalDependencies")))
                      :: Data.ProtoLens.FieldDescriptor Node
                inferedType__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "infered_type"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor Proto.Karps.Proto.Types.SQLType)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) ::
                               (Lens.Labels.Proxy#) "maybe'inferedType")))
                      :: Data.ProtoLens.FieldDescriptor Node
              in
              Data.Map.fromList
                [(Data.ProtoLens.Tag 1, locality__field_descriptor),
                 (Data.ProtoLens.Tag 2, path__field_descriptor),
                 (Data.ProtoLens.Tag 3, opName__field_descriptor),
                 (Data.ProtoLens.Tag 4, opExtra__field_descriptor),
                 (Data.ProtoLens.Tag 5, parents__field_descriptor),
                 (Data.ProtoLens.Tag 6, logicalDependencies__field_descriptor),
                 (Data.ProtoLens.Tag 7, inferedType__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens _Node'_unknownFields
              (\ x__ y__ -> x__{_Node'_unknownFields = y__})
{- | Fields :

    * 'Proto.Karps.Proto.Graph_Fields.content' @:: Lens' OpExtra Data.ByteString.ByteString@
    * 'Proto.Karps.Proto.Graph_Fields.contentDebug' @:: Lens' OpExtra Data.Text.Text@
    * 'Proto.Karps.Proto.Graph_Fields.contentBase64' @:: Lens' OpExtra Data.Text.Text@
 -}
data OpExtra = OpExtra{_OpExtra'content ::
                       !Data.ByteString.ByteString,
                       _OpExtra'contentDebug :: !Data.Text.Text,
                       _OpExtra'contentBase64 :: !Data.Text.Text,
                       _OpExtra'_unknownFields :: !Data.ProtoLens.FieldSet}
                 deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f OpExtra x a, a ~ b) =>
         Lens.Labels.HasLens f OpExtra OpExtra x a b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f OpExtra "content"
           (Data.ByteString.ByteString)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _OpExtra'content
                 (\ x__ y__ -> x__{_OpExtra'content = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f OpExtra "contentDebug" (Data.Text.Text)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _OpExtra'contentDebug
                 (\ x__ y__ -> x__{_OpExtra'contentDebug = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f OpExtra "contentBase64" (Data.Text.Text)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _OpExtra'contentBase64
                 (\ x__ y__ -> x__{_OpExtra'contentBase64 = y__}))
              Prelude.id
instance Data.Default.Class.Default OpExtra where
        def
          = OpExtra{_OpExtra'content = Data.ProtoLens.fieldDefault,
                    _OpExtra'contentDebug = Data.ProtoLens.fieldDefault,
                    _OpExtra'contentBase64 = Data.ProtoLens.fieldDefault,
                    _OpExtra'_unknownFields = ([])}
instance Data.ProtoLens.Message OpExtra where
        messageName _ = Data.Text.pack "karps.core.OpExtra"
        fieldsByTag
          = let content__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "content"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.BytesField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.ByteString.ByteString)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "content")))
                      :: Data.ProtoLens.FieldDescriptor OpExtra
                contentDebug__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "content_debug"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "contentDebug")))
                      :: Data.ProtoLens.FieldDescriptor OpExtra
                contentBase64__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "content_base64"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "contentBase64")))
                      :: Data.ProtoLens.FieldDescriptor OpExtra
              in
              Data.Map.fromList
                [(Data.ProtoLens.Tag 1, content__field_descriptor),
                 (Data.ProtoLens.Tag 2, contentDebug__field_descriptor),
                 (Data.ProtoLens.Tag 3, contentBase64__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens _OpExtra'_unknownFields
              (\ x__ y__ -> x__{_OpExtra'_unknownFields = y__})
{- | Fields :

    * 'Proto.Karps.Proto.Graph_Fields.path' @:: Lens' Path [Data.Text.Text]@
 -}
data Path = Path{_Path'path :: ![Data.Text.Text],
                 _Path'_unknownFields :: !Data.ProtoLens.FieldSet}
              deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f Path x a, a ~ b) =>
         Lens.Labels.HasLens f Path Path x a b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f Path "path" ([Data.Text.Text])
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Path'path
                 (\ x__ y__ -> x__{_Path'path = y__}))
              Prelude.id
instance Data.Default.Class.Default Path where
        def = Path{_Path'path = [], _Path'_unknownFields = ([])}
instance Data.ProtoLens.Message Path where
        messageName _ = Data.Text.pack "karps.core.Path"
        fieldsByTag
          = let path__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "path"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "path")))
                      :: Data.ProtoLens.FieldDescriptor Path
              in
              Data.Map.fromList [(Data.ProtoLens.Tag 1, path__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens _Path'_unknownFields
              (\ x__ y__ -> x__{_Path'_unknownFields = y__})